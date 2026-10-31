import 'package:pocketbase/pocketbase.dart';

import '../../features/letters/models/daily_word.dart';
import '../../features/letters/models/letter.dart';
import '../config/app_config.dart';
import '../utils/kigali_date.dart';

class NetworkException implements Exception {
  const NetworkException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PocketBaseGateway {
  PocketBaseGateway({PocketBase? client})
    : _pb = client ?? PocketBase(AppConfig.baseUrl, authStore: AuthStore());

  final PocketBase _pb;

  Future<List<Letter>> fetchLetters() async {
    try {
      final records = await _pb
          .collection('lettres')
          .getFullList(filter: 'statut = "publie"', sort: 'numero');
      return records.map(_toLetter).toList();
    } catch (_) {
      throw const NetworkException('Guhuza amakuru byanze.');
    }
  }

  Future<List<DailyWord>> fetchDailyWords() async {
    try {
      final records = await _pb
          .collection('mots_du_jour')
          .getFullList(filter: 'statut = "publie"', sort: '-date_locale');
      return records.map(_toDailyWord).toList();
    } catch (_) {
      throw const NetworkException('Guhuza amakuru byanze.');
    }
  }

  Letter _toLetter(RecordModel record) {
    final data = record.data;
    final pdfFile = _fileName(data['pdf_file']);
    final audioFile = _fileName(data['audio_file']);
    return Letter(
      id: record.id,
      numero: _asInt(data['numero']),
      slug: _asString(data['slug']),
      langue: _asString(data['langue'], fallback: 'rw'),
      titre: _asString(data['titre']),
      contenuHtml: _asString(data['contenu_html']),
      statut: _asString(data['statut'], fallback: 'publie'),
      pdfFile: pdfFile,
      pdfUrl: pdfFile == null
          ? null
          : _pb.files.getURL(record, pdfFile).toString(),
      audioFile: audioFile,
      audioUrl: audioFile == null
          ? null
          : _pb.files.getURL(record, audioFile).toString(),
      urlOrigine: _asNullableString(data['url_origine']),
      sourceKey: _asNullableString(data['source_key']),
      pdfSha256: _asNullableString(data['pdf_sha256']),
      audioSha256: _asNullableString(data['audio_sha256']),
      sourceModifiedAt: parsePocketBaseDate(data['source_modified_at']),
      pdfSizeBytes: _asNullableInt(data['pdf_size_bytes']),
      audioSizeBytes: _asNullableInt(data['audio_size_bytes']),
      audioDurationSeconds: _asNullableDouble(data['audio_duration_seconds']),
    );
  }

  DailyWord _toDailyWord(RecordModel record) {
    final data = record.data;
    final audioFile = _fileName(data['audio_extrait']);
    final letterId = _asNullableString(data['lettre_liee']);
    return DailyWord(
      id: record.id,
      dateLocale: _asString(data['date_locale']),
      langue: _asString(data['langue'], fallback: 'rw'),
      titre: _asString(data['titre']),
      citation: _asString(data['citation']),
      referenceSource: _asString(data['reference_source']),
      lettreLieeId: letterId,
      audioExtraitUrl: audioFile == null
          ? null
          : _pb.files.getURL(record, audioFile).toString(),
      sourceKey: _asString(data['source_key']),
      statut: _asString(data['statut'], fallback: 'publie'),
    );
  }

  static String? _fileName(Object? value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }
    if (value is List && value.isNotEmpty) {
      final first = value.first;
      if (first is String && first.isNotEmpty) {
        return first;
      }
    }
    return null;
  }

  static String _asString(Object? value, {String fallback = ''}) {
    if (value is String) {
      return value;
    }
    return value?.toString() ?? fallback;
  }

  static String? _asNullableString(Object? value) {
    if (value is String && value.trim().isNotEmpty) {
      return value;
    }
    return null;
  }

  static int _asInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _asNullableInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static double? _asNullableDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '');
  }
}
