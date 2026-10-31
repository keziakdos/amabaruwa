import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/text_utils.dart';
import '../../l10n/app_localizations.dart';

class MiniPlayerBar extends ConsumerWidget {
  const MiniPlayerBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audio = ref.watch(audioServiceProvider);
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: audio,
      builder: (context, _) {
        final letter = audio.current;
        if (letter == null) {
          return const SizedBox.shrink();
        }
        final duration = audio.duration;
        final position = audio.position;
        final progress = duration.inMilliseconds <= 0
            ? 0.0
            : position.inMilliseconds / duration.inMilliseconds;

        return Material(
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
            onTap: () => context.push('/player'),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.line)),
              ),
              padding: const EdgeInsets.fromLTRB(14, 8, 10, 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.headerGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.graphic_eq_rounded,
                      color: AppColors.night,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          letter.titre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          audio.error ??
                              (audio.playing
                                  ? l10n.nowPlaying
                                  : l10n.downloadPaused),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: audio.error == null
                                ? AppColors.muted
                                : AppColors.danger,
                          ),
                        ),
                        const SizedBox(height: 4),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            value: progress.clamp(0, 1),
                            minHeight: 3,
                            backgroundColor: AppColors.mist,
                            valueColor: const AlwaysStoppedAnimation(
                              AppColors.solar,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    formatDuration(position),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.muted,
                    ),
                  ),
                  IconButton(
                    tooltip: audio.playing ? l10n.pause : l10n.play,
                    onPressed: audio.toggle,
                    icon: Icon(
                      audio.playing
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
