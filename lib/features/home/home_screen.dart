import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/kigali_date.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/state_views.dart';
import '../daily_word/daily_word_selector.dart';
import '../letters/data/sync_controller.dart';
import '../letters/models/letter.dart';
import '../letters/widgets/letter_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final letters = ref.watch(lettersProvider);
    final dailySelection = ref.watch(dailyWordSelectionProvider);
    final offline = ref
        .watch(connectivityProvider)
        .maybeWhen(data: (connected) => !connected, orElse: () => false);
    final jobs = ref.watch(downloadJobsProvider).value ?? const [];
    final offlinePdf = jobs
        .where((job) => job.status == 'completed' && job.fileType == 'pdf')
        .map((job) => job.letterId)
        .toSet();
    final offlineAudio = jobs
        .where((job) => job.status == 'completed' && job.fileType == 'audio')
        .map((job) => job.letterId)
        .toSet();

    final allLetters = letters.value ?? const <Letter>[];
    final continueLetter = _continueLetter(allLetters);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          _Header(
            onMenu: () => context.push('/menu'),
            onSettings: () => context.push('/settings'),
          ),
          if (offline) OfflineBanner(message: l10n.offlineMessage),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(syncControllerProvider.notifier).syncNow(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                children: [
                  const _HeroBanner(),
                  const SizedBox(height: 4),
                  const SizedBox(height: 10),
                  _DailyWordCard(
                    selection: dailySelection,
                    onShare: (text) =>
                        SharePlus.instance.share(ShareParams(text: text)),
                    onOpenLetter: (id) => context.push('/letter/$id'),
                    onListen: (letter) async {
                      final audio = ref.read(audioServiceProvider);
                      await audio.playLetter(letter);
                      if (context.mounted) {
                        context.push('/player');
                      }
                    },
                    letters: allLetters,
                  ),
                  if (continueLetter != null) ...[
                    SectionHeader(title: l10n.continueReading),
                    _ContinueCard(
                      letter: continueLetter,
                      onTap: () => context.push('/letter/${continueLetter.id}'),
                    ),
                  ],
                  SectionHeader(
                    title: l10n.library,
                    actionLabel: l10n.openLibrary,
                    onAction: () => context.go('/letters'),
                  ),
                  if (letters.isLoading && allLetters.isEmpty)
                    const LoadingView()
                  else if (letters.hasError && allLetters.isEmpty)
                    ErrorState(
                      title: l10n.errorLoading,
                      message: l10n.firstLaunchOffline,
                      retryLabel: l10n.retry,
                      onRetry: () =>
                          ref.read(syncControllerProvider.notifier).syncNow(),
                    )
                  else if (allLetters.isEmpty)
                    EmptyState(
                      title: l10n.emptyLetters,
                      message: l10n.firstLaunchOffline,
                      actionLabel: l10n.retry,
                      onAction: () =>
                          ref.read(syncControllerProvider.notifier).syncNow(),
                    )
                  else
                    ...allLetters
                        .take(3)
                        .map(
                          (letter) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: LetterCard(
                              letter: letter,
                              pdfOffline: offlinePdf.contains(letter.id),
                              audioOffline: offlineAudio.contains(letter.id),
                              onTap: () => context.push('/letter/${letter.id}'),
                              onFavorite: () => ref
                                  .read(lettersRepositoryProvider)
                                  .toggleFavorite(
                                    letter.id,
                                    favorite: !letter.isFavorite,
                                  ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Letter? _continueLetter(List<Letter> letters) {
    if (letters.isEmpty) {
      return null;
    }
    final started =
        letters.where((letter) => letter.readingProgress > 0).toList()..sort((
          a,
          b,
        ) {
          final left = a.lastReadAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          final right = b.lastReadAt ?? DateTime.fromMillisecondsSinceEpoch(0);
          return left.compareTo(right);
        });
    return started.isEmpty ? letters.first : started.last;
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onMenu, required this.onSettings});

  final VoidCallback onMenu;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.appName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.night,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.appTagline.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: AppColors.amberText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onMenu,
            tooltip: l10n.menu,
            icon: const Icon(Icons.menu_rounded),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.55),
              foregroundColor: AppColors.night,
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: onSettings,
            tooltip: l10n.settings,
            icon: const Icon(Icons.settings_outlined),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withValues(alpha: 0.55),
              foregroundColor: AppColors.night,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 1.9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/brand/kristu-aragarutse-banner.jpg',
              fit: BoxFit.cover,
              semanticLabel: 'Kristu Aragarutse',
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.96),
                  ],
                  stops: const [0.28, 1],
                ),
              ),
            ),
            const Positioned(
              left: 16,
              right: 16,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KRISTU ARAGARUTSE',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.2,
                      color: AppColors.night,
                    ),
                  ),
                  Text(
                    'Arivugira ukuri kwe.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.amberText,
                    ),
                  ),
                  Text(
                    'AMABARUWA YA KRISTU',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.muted,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyWordCard extends StatelessWidget {
  const _DailyWordCard({
    required this.selection,
    required this.onShare,
    required this.onOpenLetter,
    required this.onListen,
    required this.letters,
  });

  final DailyWordSelection? selection;
  final void Function(String text) onShare;
  final void Function(String id) onOpenLetter;
  final void Function(Letter letter) onListen;
  final List<Letter> letters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (selection == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.dailyWordTitle,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.dailyWordNone,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }

    final word = selection!.word;
    final linked = letters
        .where((letter) => letter.id == word.lettreLieeId)
        .firstOrNull;
    final shareText =
        '${word.citation}\n${word.referenceSource}\n'
        '${l10n.attribution}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    selection!.isToday
                        ? l10n.dailyWordToday
                        : l10n.dailyWordFallback,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                      color: AppColors.amberText,
                    ),
                  ),
                ),
                if (!selection!.isToday)
                  Text(
                    formatKigaliDateText(word.dateLocale),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.muted,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '« ${word.citation} »',
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontSize: 18, height: 1.55),
            ),
            const SizedBox(height: 10),
            Text(
              word.referenceSource,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => onShare(shareText),
                  icon: const Icon(Icons.share_outlined, size: 18),
                  label: Text(l10n.share),
                ),
                if (linked != null && linked.hasAudio) ...[
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => onListen(linked),
                    icon: const Icon(Icons.volume_up_outlined, size: 18),
                    label: Text(l10n.listen),
                  ),
                ],
                if (linked != null) ...[
                  const SizedBox(width: 4),
                  IconButton(
                    tooltip: l10n.readMore,
                    onPressed: () => onOpenLetter(linked.id),
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.letter, required this.onTap});

  final Letter letter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress = letter.readingProgress;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 66,
                decoration: BoxDecoration(
                  gradient: AppColors.headerGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${letter.numero}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.night,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      letter.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      progress > 0
                          ? l10n.readingProgress((progress * 100).round())
                          : l10n.readText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: LinearProgressIndicator(
                        value: progress.clamp(0, 1),
                        minHeight: 5,
                        backgroundColor: AppColors.mist,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.gold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
