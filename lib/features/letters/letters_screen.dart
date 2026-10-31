import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/database/app_database.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/state_views.dart';
import 'data/sync_controller.dart';
import 'models/letter.dart';
import 'widgets/letter_card.dart';

enum _LetterFilter { all, favorites, audio, offline }

class LettersScreen extends ConsumerStatefulWidget {
  const LettersScreen({super.key});

  @override
  ConsumerState<LettersScreen> createState() => _LettersScreenState();
}

class _LettersScreenState extends ConsumerState<LettersScreen> {
  final _searchController = TextEditingController();
  _LetterFilter _filter = _LetterFilter.all;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lettersAsync = ref.watch(lettersProvider);
    final jobs = ref.watch(downloadJobsProvider).value ?? const <DownloadJob>[];
    final syncing = ref.watch(syncControllerProvider).syncing;
    final offline = ref
        .watch(connectivityProvider)
        .maybeWhen(data: (connected) => !connected, orElse: () => false);

    final offlinePdf = jobs
        .where((job) => job.status == 'completed' && job.fileType == 'pdf')
        .map((job) => job.letterId)
        .toSet();
    final offlineAudio = jobs
        .where((job) => job.status == 'completed' && job.fileType == 'audio')
        .map((job) => job.letterId)
        .toSet();

    final letters = _filterLetters(
      lettersAsync.value ?? const <Letter>[],
      offlinePdf: offlinePdf,
      offlineAudio: offlineAudio,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.lettersTitle),
        actions: [
          IconButton(
            tooltip: l10n.syncNow,
            onPressed: syncing
                ? null
                : () => ref.read(syncControllerProvider.notifier).syncNow(),
            icon: syncing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          if (offline) OfflineBanner(message: l10n.offlineMessage),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: l10n.close,
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 54,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                _FilterChip(
                  label: l10n.filterAll,
                  selected: _filter == _LetterFilter.all,
                  onSelected: () => setState(() => _filter = _LetterFilter.all),
                ),
                _FilterChip(
                  label: l10n.filterFavorites,
                  selected: _filter == _LetterFilter.favorites,
                  onSelected: () =>
                      setState(() => _filter = _LetterFilter.favorites),
                ),
                _FilterChip(
                  label: l10n.filterAudio,
                  selected: _filter == _LetterFilter.audio,
                  onSelected: () =>
                      setState(() => _filter = _LetterFilter.audio),
                ),
                _FilterChip(
                  label: l10n.filterOffline,
                  selected: _filter == _LetterFilter.offline,
                  onSelected: () =>
                      setState(() => _filter = _LetterFilter.offline),
                ),
              ],
            ),
          ),
          Expanded(
            child: lettersAsync.isLoading && lettersAsync.value == null
                ? const LoadingView()
                : lettersAsync.hasError && lettersAsync.value == null
                ? ErrorState(
                    title: l10n.errorLoading,
                    message: l10n.firstLaunchOffline,
                    retryLabel: l10n.retry,
                    onRetry: () =>
                        ref.read(syncControllerProvider.notifier).syncNow(),
                  )
                : letters.isEmpty
                ? EmptyState(
                    title: l10n.noResults,
                    message: l10n.offlineMessage,
                    icon: Icons.search_off_rounded,
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        ref.read(syncControllerProvider.notifier).syncNow(),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                      itemCount: letters.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final letter = letters[index];
                        return LetterCard(
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
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  List<Letter> _filterLetters(
    List<Letter> letters, {
    required Set<String> offlinePdf,
    required Set<String> offlineAudio,
  }) {
    final query = _query.trim().toLowerCase();
    return letters.where((letter) {
      if (query.isNotEmpty &&
          !letter.titre.toLowerCase().contains(query) &&
          !letter.numero.toString().contains(query)) {
        return false;
      }
      return switch (_filter) {
        _LetterFilter.all => true,
        _LetterFilter.favorites => letter.isFavorite,
        _LetterFilter.audio => letter.hasAudio,
        _LetterFilter.offline =>
          offlinePdf.contains(letter.id) || offlineAudio.contains(letter.id),
      };
    }).toList();
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        showCheckmark: false,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: selected ? Colors.white : null,
        ),
        selectedColor: const Color(0xFF25364A),
        backgroundColor: Theme.of(context).colorScheme.surface,
        side: BorderSide(color: Theme.of(context).dividerColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      ),
    );
  }
}
