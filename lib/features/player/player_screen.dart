import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/audio/audio_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/text_utils.dart';
import '../../l10n/app_localizations.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final audio = ref.watch(audioServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.close,
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
        ),
        title: Text(l10n.audioTitle),
      ),
      body: ListenableBuilder(
        listenable: audio,
        builder: (context, _) {
          final letter = audio.current;
          if (letter == null) {
            return Center(child: Text(l10n.noAudio));
          }
          final duration = audio.duration;
          final position = audio.position;
          final maxMillis = duration.inMilliseconds > 0
              ? duration.inMilliseconds
              : 1;
          final value = position.inMilliseconds.clamp(0, maxMillis).toDouble();

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Image.asset(
                      'assets/images/brand/kristu-aragarutse-banner.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  letter.titre,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Amabaruwa · ${l10n.listen}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (audio.error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    audio.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.danger),
                  ),
                ],
                const SizedBox(height: 20),
                Slider(
                  value: value.toDouble(),
                  max: maxMillis.toDouble(),
                  onChanged: (millis) =>
                      audio.seek(Duration(milliseconds: millis.round())),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(position),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                      Text(
                        formatDuration(duration),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: l10n.skipBack15,
                      onPressed: () => audio.skip(const Duration(seconds: -15)),
                      icon: const Icon(Icons.replay_10_rounded, size: 32),
                    ),
                    const SizedBox(width: 14),
                    _PlayButton(audio: audio, l10n: l10n),
                    const SizedBox(width: 14),
                    IconButton(
                      tooltip: l10n.skipForward15,
                      onPressed: () => audio.skip(const Duration(seconds: 15)),
                      icon: const Icon(Icons.forward_10_rounded, size: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    PopupMenuButton<double>(
                      tooltip: l10n.speed,
                      onSelected: audio.setSpeed,
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 0.75, child: Text('0,75×')),
                        PopupMenuItem(value: 1, child: Text('1,0×')),
                        PopupMenuItem(value: 1.25, child: Text('1,25×')),
                        PopupMenuItem(value: 1.5, child: Text('1,5×')),
                        PopupMenuItem(value: 2, child: Text('2,0×')),
                      ],
                      child: _OptionChip(
                        icon: Icons.speed_rounded,
                        label:
                            {
                              0.75: '0,75×',
                              1.0: '1,0×',
                              1.25: '1,25×',
                              1.5: '1,5×',
                              2.0: '2,0×',
                            }[audio.speed] ??
                            '${audio.speed}×',
                      ),
                    ),
                    PopupMenuButton<int>(
                      tooltip: l10n.sleepTimer,
                      onSelected: (minutes) {
                        audio.setSleepTimer(
                          minutes == 0 ? null : Duration(minutes: minutes),
                        );
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 0, child: Text(l10n.sleepOff)),
                        PopupMenuItem(value: 15, child: Text(l10n.minutes15)),
                        PopupMenuItem(value: 30, child: Text(l10n.minutes30)),
                        PopupMenuItem(value: 60, child: Text(l10n.minutes60)),
                      ],
                      child: _OptionChip(
                        icon: Icons.bedtime_outlined,
                        label: audio.sleepEndsAt == null
                            ? l10n.sleepTimer
                            : l10n.sleepActive,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.audio, required this.l10n});

  final AudioService audio;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: AppColors.solar,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IconButton(
        tooltip: audio.playing ? l10n.pause : l10n.play,
        onPressed: audio.toggle,
        icon: Icon(
          audio.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 34,
          color: AppColors.night,
        ),
      ),
    );
  }
}

class _OptionChip extends StatelessWidget {
  const _OptionChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
