import 'package:flutter_test/flutter_test.dart';

import 'package:amabaruwa/core/utils/kigali_date.dart';
import 'package:amabaruwa/features/daily_word/daily_word_selector.dart';
import 'package:amabaruwa/features/letters/models/daily_word.dart';

DailyWord _word(String date, {String id = 'w1', bool available = true}) {
  return DailyWord(
    id: id,
    dateLocale: date,
    langue: 'rw',
    titre: 'Urugero',
    citation: 'Urugero gusa',
    referenceSource: 'Urugero',
    sourceKey: 'test:$id',
    statut: 'publie',
    remoteAvailable: available,
  );
}

void main() {
  group('Africa/Kigali', () {
    test('utilise UTC+2 sans heure d’été', () {
      final reference = DateTime.utc(2026, 10, 31, 22, 30);
      expect(kigaliDateKey(reference), '2026-11-01');
    });

    test('bascule de jour à minuit local', () {
      expect(kigaliDateKey(DateTime.utc(2026, 10, 31, 21, 59)), '2026-10-31');
      expect(kigaliDateKey(DateTime.utc(2026, 10, 31, 22, 0)), '2026-11-01');
    });

    test('formate la date en kinyarwanda', () {
      expect(formatKigaliDateText('2026-10-31'), '31 Ukwakira 2026');
    });
  });

  group('Sélection du Mot du jour', () {
    test('renvoie le contenu du jour quand il existe', () {
      final selection = selectDailyWord([
        _word('2026-10-31'),
        _word('2026-10-30', id: 'w2'),
      ], now: DateTime.utc(2026, 10, 31, 8));
      expect(selection, isNotNull);
      expect(selection!.isToday, isTrue);
      expect(selection.word.dateLocale, '2026-10-31');
    });

    test('renvoie le dernier contenu avec sa date si le jour manque', () {
      final selection = selectDailyWord([
        _word('2026-09-01'),
        _word('2026-09-15', id: 'w2'),
      ], now: DateTime.utc(2026, 10, 31, 8));
      expect(selection, isNotNull);
      expect(selection!.isToday, isFalse);
      expect(selection.word.dateLocale, '2026-09-15');
    });

    test('ignore les contenus indisponibles et les brouillons', () {
      final selection = selectDailyWord([
        _word('2026-10-31', available: false),
        DailyWord(
          id: 'draft',
          dateLocale: '2026-10-31',
          langue: 'rw',
          titre: 'Urugero',
          citation: 'Urugero',
          referenceSource: 'Urugero',
          sourceKey: 'draft',
          statut: 'brouillon',
        ),
      ], now: DateTime.utc(2026, 10, 31, 8));
      expect(selection, isNull);
    });
  });
}
