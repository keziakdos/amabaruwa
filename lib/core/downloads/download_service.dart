import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/letters/models/letter.dart';
import '../database/app_database.dart';

class DownloadException implements Exception {
  const DownloadException(this.message);

  final String message;
}

class DownloadService {
  DownloadService(this._db, {Dio? dio}) : _dio = dio ?? Dio();

  final AppDatabase _db;
  final Dio _dio;
  final Map<int, CancelToken> _tokens = {};
  bool _processing = false;

  Stream<List<DownloadJob>> watchJobs() => _db.watchDownloadJobs();

  Future<void> initialize() async {
    await _db.resetInterruptedDownloads();
    unawaited(_processQueue());
  }

  Future<DownloadJob?> findJob(String letterId, String fileType) {
    return _db.findDownloadJob(letterId, fileType);
  }

  Future<void> enqueue(
    Letter letter,
    String fileType, {
    bool force = false,
  }) async {
    final target = _targetFor(letter, fileType);
    final existing = await _db.findDownloadJob(letter.id, fileType);

    if (!force && existing != null && existing.status == 'completed') {
      final file = existing.localPath == null
          ? null
          : File(existing.localPath!);
      if (file != null &&
          await verifyFileIntegrity(
            file,
            expectedSize: existing.totalBytes,
            expectedSha256: existing.sha256,
          )) {
        return;
      }
    }

    final companion = DownloadJobsCompanion(
      letterId: Value(letter.id),
      fileType: Value(fileType),
      remoteUrl: Value(target.url),
      fileName: Value(target.fileName),
      status: const Value('pending'),
      bytesReceived: const Value(0),
      totalBytes: Value(target.size),
      sha256: Value(target.sha256),
      localPath: const Value(null),
      error: const Value(null),
      attempts: Value(existing?.attempts ?? 0),
      updatedAt: Value(DateTime.now().toUtc()),
    );
    await _db.upsertDownloadJob(companion);
    unawaited(_processQueue());
  }

  Future<void> retry(int id) async {
    await _db.updateDownloadJob(
      id,
      const DownloadJobsCompanion(status: Value('pending'), error: Value(null)),
    );
    unawaited(_processQueue());
  }

  Future<void> cancel(int id) async {
    _tokens[id]?.cancel('annulé');
    _tokens.remove(id);
    await _db.updateDownloadJob(
      id,
      const DownloadJobsCompanion(
        status: Value('paused'),
        error: Value('Gukurura byahagaritswe. Ongera ugerageze.'),
      ),
    );
  }

  Future<void> delete(int id) async {
    _tokens[id]?.cancel('supprimé');
    _tokens.remove(id);
    final job = await (_db.select(
      _db.downloadJobs,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (job?.localPath != null) {
      final file = File(job!.localPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }
    if (job != null) {
      final part = await _partFile(job);
      if (await part.exists()) {
        await part.delete();
      }
    }
    await _db.deleteDownloadJob(id);
  }

  Future<String?> localFilePath(String letterId, String fileType) async {
    final job = await _db.findDownloadJob(letterId, fileType);
    if (job == null || job.status != 'completed' || job.localPath == null) {
      return null;
    }
    final file = File(job.localPath!);
    if (!await file.exists()) {
      return null;
    }
    if (!await verifyFileIntegrity(
      file,
      expectedSize: job.totalBytes,
      expectedSha256: job.sha256,
    )) {
      return null;
    }
    return job.localPath;
  }

  Future<void> _processQueue() async {
    if (_processing) {
      return;
    }
    _processing = true;
    try {
      while (true) {
        final pending = await _db.pendingDownloadJobs();
        if (pending.isEmpty) {
          break;
        }
        final job = pending.firstWhere(
          (item) => item.status == 'pending',
          orElse: () => pending.first,
        );
        await _runJob(job);
      }
    } finally {
      _processing = false;
    }
  }

  Future<void> _runJob(DownloadJob job) async {
    final token = CancelToken();
    _tokens[job.id] = token;
    await _db.updateDownloadJob(
      job.id,
      DownloadJobsCompanion(
        status: const Value('running'),
        attempts: Value(job.attempts + 1),
        error: const Value(null),
      ),
    );

    final directory = await _downloadDirectory();
    final finalFile = File('${directory.path}/${job.fileName}');
    final part = File('${finalFile.path}.part');

    try {
      var offset = 0;
      if (await part.exists()) {
        offset = await part.length();
      }

      final headers = <String, String>{};
      if (offset > 0) {
        headers['Range'] = 'bytes=$offset-';
      }

      final response = await _dio.get<ResponseBody>(
        job.remoteUrl,
        options: Options(
          responseType: ResponseType.stream,
          headers: headers,
          followRedirects: true,
          validateStatus: (status) => status != null && status < 400,
        ),
        cancelToken: token,
      );

      final status = response.statusCode ?? 0;
      final append = offset > 0 && status == 206;
      if (!append) {
        offset = 0;
        if (await part.exists()) {
          await part.delete();
        }
      }

      final total = _resolveTotal(response, offset);
      final sink = part.openWrite(
        mode: append ? FileMode.append : FileMode.write,
      );
      var written = offset;
      var lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

      try {
        await for (final chunk in response.data!.stream) {
          if (token.isCancelled) {
            throw DioException.requestCancelled(
              requestOptions: response.requestOptions,
              reason: 'annulé',
            );
          }
          sink.add(chunk);
          written += chunk.length;
          final now = DateTime.now();
          if (now.difference(lastUpdate).inMilliseconds > 400) {
            lastUpdate = now;
            await _db.updateDownloadJob(
              job.id,
              DownloadJobsCompanion(
                bytesReceived: Value(written),
                totalBytes: Value(total),
              ),
            );
          }
        }
      } finally {
        await sink.flush();
        await sink.close();
      }

      final expectedSize = job.totalBytes ?? total;
      if (expectedSize != null && written != expectedSize) {
        throw const DownloadException('Dosiye ntuzuye. Ongera ugerageze.');
      }
      if (job.sha256 != null) {
        final digest = await computeSha256File(part);
        if (digest != job.sha256) {
          throw const DownloadException('Dosiye yononekare. Ongera ugerageze.');
        }
      }

      if (await finalFile.exists()) {
        await finalFile.delete();
      }
      await part.rename(finalFile.path);

      await _db.updateDownloadJob(
        job.id,
        DownloadJobsCompanion(
          status: const Value('completed'),
          bytesReceived: Value(written),
          totalBytes: Value(expectedSize ?? written),
          localPath: Value(finalFile.path),
          error: const Value(null),
        ),
      );
    } on DioException catch (error) {
      if (CancelToken.isCancel(error)) {
        await _db.updateDownloadJob(
          job.id,
          const DownloadJobsCompanion(
            status: Value('paused'),
            error: Value('Gukurura byahagaritswe. Ongera ugerageze.'),
          ),
        );
      } else {
        final message = _isDiskFull(error)
            ? 'Ububiko ntibuhagije kuri iyi dosiye.'
            : 'Gukurura byanze. Ongera ugerageze.';
        await _db.updateDownloadJob(
          job.id,
          DownloadJobsCompanion(
            status: const Value('failed'),
            error: Value(message),
          ),
        );
      }
    } on DownloadException catch (error) {
      await _db.updateDownloadJob(
        job.id,
        DownloadJobsCompanion(
          status: const Value('failed'),
          error: Value(error.message),
        ),
      );
    } catch (error) {
      final message = _isDiskFull(error)
          ? 'Ububiko ntibuhagije kuri iyi dosiye.'
          : 'Dosiye ntuzuye cyangwa yononekare. Ongera ugerageze.';
      await _db.updateDownloadJob(
        job.id,
        DownloadJobsCompanion(
          status: const Value('failed'),
          error: Value(message),
        ),
      );
    } finally {
      _tokens.remove(job.id);
    }
  }

  _DownloadTarget _targetFor(Letter letter, String fileType) {
    if (fileType == 'pdf') {
      final url = letter.pdfUrl;
      if (url == null || url.isEmpty) {
        throw const DownloadException('Nta PDF ibonetse kuri iyi baruwa.');
      }
      return _DownloadTarget(
        url: url,
        size: letter.pdfSizeBytes,
        sha256: letter.pdfSha256,
        fileName: 'ibaruwa-${letter.numero}-${letter.id}.pdf',
      );
    }
    final url = letter.audioUrl;
    if (url == null || url.isEmpty) {
      throw const DownloadException('Nta majwi abonetse kuri iyi baruwa.');
    }
    return _DownloadTarget(
      url: url,
      size: letter.audioSizeBytes,
      sha256: letter.audioSha256,
      fileName: 'ibaruwa-${letter.numero}-${letter.id}.mp3',
    );
  }

  Future<Directory> _downloadDirectory() async {
    final base = await getApplicationSupportDirectory();
    final directory = Directory('${base.path}/downloads');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<File> _partFile(DownloadJob job) async {
    final directory = await _downloadDirectory();
    return File('${directory.path}/${job.fileName}.part');
  }

  static int? _resolveTotal(Response<ResponseBody> response, int offset) {
    final contentRange = response.headers.value('content-range');
    if (contentRange != null) {
      final match = RegExp(r'/(\d+)$').firstMatch(contentRange);
      if (match != null) {
        return int.tryParse(match.group(1)!);
      }
    }
    final length = response.headers.value('content-length');
    if (length != null) {
      final parsed = int.tryParse(length);
      if (parsed != null) {
        return parsed + offset;
      }
    }
    return null;
  }

  static bool _isDiskFull(Object error) {
    final text = error.toString().toLowerCase();
    return text.contains('no space left') ||
        text.contains('enospc') ||
        text.contains('disk full');
  }
}

Future<String> computeSha256File(File file) async {
  final digest = await sha256.bind(file.openRead()).first;
  return digest.toString();
}

Future<bool> verifyFileIntegrity(
  File file, {
  int? expectedSize,
  String? expectedSha256,
}) async {
  if (!await file.exists()) {
    return false;
  }
  final length = await file.length();
  if (expectedSize != null && length != expectedSize) {
    return false;
  }
  if (expectedSha256 != null) {
    return await computeSha256File(file) == expectedSha256;
  }
  return length > 0;
}

class _DownloadTarget {
  const _DownloadTarget({
    required this.url,
    required this.fileName,
    this.size,
    this.sha256,
  });

  final String url;
  final String fileName;
  final int? size;
  final String? sha256;
}
