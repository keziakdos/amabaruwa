import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import '../../app/providers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/state_views.dart';
import 'models/letter.dart';

class PdfScreen extends ConsumerWidget {
  const PdfScreen({super.key, required this.letterId});

  final String letterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final letterAsync = ref.watch(letterProvider(letterId));
    final letter = letterAsync.value;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.pdfTitle)),
      body: letter == null
          ? (letterAsync.isLoading
                ? const LoadingView()
                : EmptyState(title: l10n.letterNotFound))
          : !letter.hasPdf
          ? EmptyState(title: l10n.noPdf)
          : _PdfBody(letter: letter),
    );
  }
}

class _PdfBody extends ConsumerStatefulWidget {
  const _PdfBody({required this.letter});

  final Letter letter;

  @override
  ConsumerState<_PdfBody> createState() => _PdfBodyState();
}

class _PdfBodyState extends ConsumerState<_PdfBody> {
  late final Future<PdfControllerPinch> _controllerFuture;
  PdfControllerPinch? _controller;

  @override
  void initState() {
    super.initState();
    _controllerFuture = _createController();
  }

  Future<PdfControllerPinch> _createController() async {
    final service = ref.read(downloadServiceProvider);
    var path = await service.localFilePath(widget.letter.id, 'pdf');

    if (path == null) {
      final directory = await getTemporaryDirectory();
      final cacheFile = File(
        '${directory.path}/preview-${widget.letter.id}.pdf',
      );
      if (!await cacheFile.exists()) {
        final response = await Dio().get<List<int>>(
          widget.letter.pdfUrl!,
          options: Options(
            responseType: ResponseType.bytes,
            receiveTimeout: const Duration(seconds: 90),
          ),
        );
        final bytes = response.data;
        if (bytes == null || bytes.isEmpty) {
          throw StateError('PDF vide');
        }
        await cacheFile.writeAsBytes(bytes, flush: true);
      }
      path = cacheFile.path;
    }

    final controller = PdfControllerPinch(document: PdfDocument.openFile(path));
    _controller = controller;
    return controller;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FutureBuilder<PdfControllerPinch>(
      future: _controllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingView();
        }
        if (snapshot.hasError || snapshot.data == null) {
          return EmptyState(
            title: l10n.pdfUnavailableOffline,
            message: l10n.invalidFile,
            icon: Icons.picture_as_pdf_outlined,
          );
        }
        return Stack(
          children: [
            PdfViewPinch(controller: snapshot.data!),
            Positioned(
              right: 12,
              bottom: 16,
              child: Material(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(99),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: PdfPageNumber(
                    controller: snapshot.data!,
                    builder: (_, state, loadingState, pagesCount) {
                      return Text(
                        '$state / ${pagesCount ?? 0}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
