import 'package:collection/collection.dart';

import '../../core/utils/kigali_date.dart';
import '../letters/models/daily_word.dart';

class DailyWordSelection {
  const DailyWordSelection({required this.word, required this.isToday});

  final DailyWord word;
  final bool isToday;
}

/// Sélectionne le mot du jour exact, sinon le dernier contenu publié disponible.
DailyWordSelection? selectDailyWord(
  Iterable<DailyWord> words, {
  DateTime? now,
}) {
  final published =
      words
          .where((word) => word.statut == 'publie' && word.remoteAvailable)
          .toList()
        ..sort((a, b) => b.dateLocale.compareTo(a.dateLocale));
  if (published.isEmpty) {
    return null;
  }

  final today = kigaliDateKey(now);
  final exact = published.firstWhereOrNull((word) => word.dateLocale == today);
  if (exact != null) {
    return DailyWordSelection(word: exact, isToday: true);
  }
  return DailyWordSelection(word: published.first, isToday: false);
}
