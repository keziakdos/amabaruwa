import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/database/app_database.dart';
import '../../core/downloads/download_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/text_utils.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/state_views.dart';
import '../letters/models/letter.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final jobsAsync = ref.watch(downloadJobsProvider);
    final letters = ref.watch(lettersProvider).value ?? const <Letter>[];
    final jobs = jobsAsync.value ?? const <DownloadJob>[];
    final service = ref.watch(downloadServiceProvider);
    final titles = {for (final letter in letters) letter.id: letter.titre};

    final completed = jobs.where((job) => job.status == 'completed');
    final usedBytes = completed.fold<int>(
      0,
      (sum, job) => sum + (job.totalBytes ?? 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.downloadsTitle),
        actions: [
          if (completed.isNotEmpty)
            IconButton(
              tooltip: l10n.clearDownloads,
              onPressed: () => _confirmClear(context, ref, completed),
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: jobsAsync.isLoading && jobs.isEmpty
          ? const LoadingView()
          : jobs.isEmpty
          ? EmptyState(
              title: l10n.downloadsEmpty,
              message: l10n.downloadsEmptyHint,
              icon: Icons.download_outlined,
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.mist,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.sd_storage_outlined,
                            color: AppColors.night,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.storageUsed,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.storageSummary(formatBytes(usedBytes)),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                ...jobs.map(
                  (job) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _DownloadCard(
                      job: job,
                      title: titles[job.letterId] ?? job.letterId,
                      onCancel: () => service.cancel(job.id),
                      onRetry: () => service.retry(job.id),
                      onDelete: () => _confirmDelete(context, service, job),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    DownloadService service,
    DownloadJob job,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await service.delete(job.id);
    }
  }

  Future<void> _confirmClear(
    BuildContext context,
    WidgetRef ref,
    Iterable<DownloadJob> jobs,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearDownloads),
        content: Text(l10n.clearDownloadsBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.clear),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final service = ref.read(downloadServiceProvider);
      for (final job in jobs.toList()) {
        await service.delete(job.id);
      }
    }
  }
}

class _DownloadCard extends StatelessWidget {
  const _DownloadCard({
    required this.job,
    required this.title,
    required this.onCancel,
    required this.onRetry,
    required this.onDelete,
  });

  final DownloadJob job;
  final String title;
  final VoidCallback onCancel;
  final VoidCallback onRetry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isAudio = job.fileType == 'audio';
    final total = job.totalBytes ?? 0;
    final progress = total <= 0 ? 0.0 : job.bytesReceived / total;
    final status = switch (job.status) {
      'completed' => l10n.downloadCompleted,
      'running' => l10n.downloading,
      'pending' => l10n.downloadPending,
      'paused' => l10n.downloadPaused,
      'failed' => l10n.downloadFailed,
      _ => job.status,
    };
    final statusColor = switch (job.status) {
      'completed' => AppColors.success,
      'failed' => AppColors.danger,
      _ => AppColors.muted,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.mist,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                isAudio ? 'MP3' : 'PDF',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: AppColors.night,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    statusColor == AppColors.danger
                        ? (job.error ?? status)
                        : '$status · ${formatBytes(job.totalBytes)}',
                    style: TextStyle(fontSize: 11, color: statusColor),
                  ),
                  if (job.status == 'running' || job.status == 'pending') ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: job.status == 'pending' ? null : progress,
                        minHeight: 5,
                        backgroundColor: AppColors.mist,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.gold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (job.status == 'running' || job.status == 'pending')
              IconButton(
                tooltip: l10n.downloadCancel,
                onPressed: onCancel,
                icon: const Icon(Icons.pause_circle_outline_rounded),
              )
            else if (job.status == 'paused' || job.status == 'failed')
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: l10n.downloadRetry,
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                  ),
                  IconButton(
                    tooltip: l10n.downloadDelete,
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                  ),
                ],
              )
            else
              IconButton(
                tooltip: l10n.downloadDelete,
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded),
              ),
          ],
        ),
      ),
    );
  }
}
