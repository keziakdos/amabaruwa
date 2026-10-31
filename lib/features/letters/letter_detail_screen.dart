import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/providers.dart';
import '../../core/database/app_database.dart';
import '../../core/downloads/download_service.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/state_views.dart';
import '../settings/settings_controller.dart';
import 'data/letters_repository.dart';
import 'data/sync_controller.dart';
import 'models/letter.dart';
import 'widgets/letter_content.dart';

class LetterDetailScreen extends ConsumerStatefulWidget {
  const LetterDetailScreen({super.key, required this.letterId});

  final String letterId;

  @override
  ConsumerState<LetterDetailScreen> createState() => _LetterDetailScreenState();
}

class _LetterDetailScreenState extends ConsumerState<LetterDetailScreen> {
  final _scrollController = ScrollController();
  late final LettersRepository _repository;
  Timer? _saveDebounce;
  bool _restored = false;
  String? _restoredFor;

  @override
  void initState() {
    super.initState();
    _repository = ref.read(lettersRepositoryProvider);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _persistProgress();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 900), _persistProgress);
  }

  void _persistProgress() {
    if (!_scrollController.hasClients) {
      return;
    }
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    final progress = max <= 0 ? 0.0 : (offset / max).clamp(0.0, 1.0);
    unawaited(_repository.saveReadingProgress(widget.letterId, progress));
  }

  void _restoreProgress(Letter letter) {
    if (_restored || _restoredFor == letter.id) {
      return;
    }
    _restored = true;
    _restoredFor = letter.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      final max = _scrollController.position.maxScrollExtent;
      if (max <= 0 || letter.readingProgress <= 0) {
        return;
      }
      _scrollController.jumpTo((letter.readingProgress * max).clamp(0.0, max));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final letterAsync = ref.watch(letterProvider(widget.letterId));
    final letter = letterAsync.value;
    final settings = ref.watch(settingsControllerProvider);
    final jobs = ref.watch(downloadJobsProvider).value ?? const [];
    final pdfJob = jobs
        .where(
          (job) => job.letterId == widget.letterId && job.fileType == 'pdf',
        )
        .firstOrNull;
    final audioJob = jobs
        .where(
          (job) => job.letterId == widget.letterId && job.fileType == 'audio',
        )
        .firstOrNull;

    if (letter == null) {
      return Scaffold(
        appBar: AppBar(),
        body: letterAsync.isLoading
            ? const LoadingView()
            : EmptyState(
                title: l10n.letterNotFound,
                message: l10n.errorLoading,
                actionLabel: l10n.syncNow,
                onAction: () =>
                    ref.read(syncControllerProvider.notifier).syncNow(),
              ),
      );
    }

    _restoreProgress(letter);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.letterNumber(letter.numero),
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            tooltip: letter.isFavorite
                ? l10n.favoriteRemoved
                : l10n.favoriteAdded,
            onPressed: () => ref
                .read(lettersRepositoryProvider)
                .toggleFavorite(letter.id, favorite: !letter.isFavorite),
            icon: Icon(
              letter.isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: letter.isFavorite ? AppColors.gold : null,
            ),
          ),
          IconButton(
            tooltip: l10n.share,
            onPressed: () => SharePlus.instance.share(
              ShareParams(
                text:
                    '${letter.titre}\n'
                    '${letter.urlOrigine ?? ''}\n'
                    '${l10n.attribution}',
              ),
            ),
            icon: const Icon(Icons.share_outlined),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'settings') {
                _showReadingSettings(context, l10n);
              } else if (value == 'source') {
                _openSource(letter.urlOrigine);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.text_fields_rounded),
                  title: Text(l10n.readingSettings),
                ),
              ),
              PopupMenuItem(
                value: 'source',
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.public_rounded),
                  title: Text(l10n.sourceLink),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: LinearProgressIndicator(
              value: letter.readingProgress.clamp(0, 1),
              minHeight: 3,
              backgroundColor: isDark ? AppColors.darkLine : AppColors.mist,
              valueColor: const AlwaysStoppedAnimation(AppColors.solar),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    letter.titre,
                    style: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w400, height: 1.3),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.attribution,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 18),
                  if (letter.hasText)
                    LetterContent(
                      html: letter.contenuHtml,
                      fontSize: settings.fontSize,
                      color: textColor,
                    )
                  else
                    Text(l10n.errorLoading),
                  const Divider(height: 40),
                  Text(
                    letter.urlOrigine ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.attribution,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: letter.hasAudio ? () => _playAudio(letter) : null,
                  icon: const Icon(Icons.headphones_rounded, size: 19),
                  label: Text(l10n.listen),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: letter.hasPdf
                      ? () => context.push('/letter/${letter.id}/pdf')
                      : null,
                  icon: const Icon(Icons.picture_as_pdf_outlined, size: 19),
                  label: Text('PDF'),
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: l10n.downloadPack,
                enabled: letter.hasPdf || letter.hasAudio,
                onSelected: (value) => _download(letter, value),
                itemBuilder: (context) => [
                  if (letter.hasPdf)
                    PopupMenuItem(
                      value: 'pdf',
                      child: _downloadItem(l10n.downloadPdf, pdfJob, l10n),
                    ),
                  if (letter.hasAudio)
                    PopupMenuItem(
                      value: 'audio',
                      child: _downloadItem(l10n.downloadAudio, audioJob, l10n),
                    ),
                  if (letter.hasPdf && letter.hasAudio)
                    PopupMenuItem(
                      value: 'pack',
                      child: Text(l10n.downloadPack),
                    ),
                ],
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: AppColors.solar,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.download_rounded,
                    color: AppColors.night,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _downloadItem(String label, DownloadJob? job, AppLocalizations l10n) {
    String? trailing;
    if (job != null) {
      trailing = switch (job.status) {
        'completed' => l10n.downloaded,
        'running' || 'pending' => l10n.downloading,
        'paused' => l10n.downloadPaused,
        'failed' => l10n.downloadFailed,
        _ => null,
      };
    }
    return Row(
      children: [
        Expanded(child: Text(label)),
        if (trailing != null)
          Text(
            trailing,
            style: const TextStyle(fontSize: 11, color: AppColors.muted),
          ),
      ],
    );
  }

  Future<void> _playAudio(Letter letter) async {
    final service = ref.read(downloadServiceProvider);
    final audio = ref.read(audioServiceProvider);
    final localPath = await service.localFilePath(letter.id, 'audio');
    await audio.playLetter(letter, localPath: localPath);
    if (mounted) {
      context.push('/player');
    }
  }

  Future<void> _download(Letter letter, String type) async {
    final service = ref.read(downloadServiceProvider);
    final l10n = AppLocalizations.of(context);
    try {
      if (type == 'pdf' || type == 'pack') {
        await service.enqueue(letter, 'pdf');
      }
      if (type == 'audio' || type == 'pack') {
        await service.enqueue(letter, 'audio');
      }
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.downloadInProgress)));
      }
    } on DownloadException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    }
  }

  Future<void> _openSource(String? url) async {
    if (url == null || url.isEmpty) {
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _showReadingSettings(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final settings = ref.watch(settingsControllerProvider);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.readingSettings,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.fontSize,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.decreaseFont,
                          onPressed: () => ref
                              .read(settingsControllerProvider.notifier)
                              .decreaseFont(),
                          icon: const Icon(Icons.text_decrease_rounded),
                        ),
                        Text(
                          settings.fontSize.round().toString(),
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          tooltip: l10n.increaseFont,
                          onPressed: () => ref
                              .read(settingsControllerProvider.notifier)
                              .increaseFont(),
                          icon: const Icon(Icons.text_increase_rounded),
                        ),
                      ],
                    ),
                    Slider(
                      value: settings.fontSize,
                      min: 14,
                      max: 26,
                      divisions: 6,
                      onChanged: (value) => ref
                          .read(settingsControllerProvider.notifier)
                          .setFontSize(value),
                    ),
                    Text(
                      l10n.fontPreview,
                      style: TextStyle(
                        fontSize: settings.fontSize,
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
