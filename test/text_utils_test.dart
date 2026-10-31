import 'package:flutter_test/flutter_test.dart';

import 'package:amabaruwa/core/utils/text_utils.dart';
import 'package:amabaruwa/features/letters/models/letter.dart';

void main() {
  group('Texte', () {
    test('extrait le texte du HTML sans balises', () {
      expect(
        htmlToPlainText('<p>Ibaruwa <strong>ya</strong> mbere</p>'),
        'Ibaruwa ya mbere',
      );
    });

    test('tronque l’aperçu avec une ellipse', () {
      final preview = previewText('<p>${'a' * 300}</p>', maxLength: 20);
      expect(preview.length, 21);
      expect(preview.endsWith('…'), isTrue);
    });

    test('formate durées et tailles', () {
      expect(formatDuration(const Duration(seconds: 75)), '1:15');
      expect(
        formatDuration(const Duration(minutes: 62, seconds: 5)),
        '1:02:05',
      );
      expect(formatBytes(1024), '1.0 Ko');
      expect(formatBytes(null), '—');
    });
  });

  group('Modèle Letter', () {
    const letter = Letter(
      id: 'l1',
      numero: 1,
      slug: 'ibaruwa-ya-mbere',
      langue: 'rw',
      titre: 'Ibaruwa ya mbere',
      contenuHtml: '<p>Urugero</p>',
      statut: 'publie',
      pdfUrl: 'https://example.test/f.pdf',
      audioUrl: 'https://example.test/a.mp3',
    );

    test('détecte les fichiers disponibles', () {
      expect(letter.hasPdf, isTrue);
      expect(letter.hasAudio, isTrue);
      expect(letter.hasText, isTrue);
    });

    test('copyWith conserve les données non modifiées', () {
      final updated = letter.copyWith(isFavorite: true, readingProgress: 0.4);
      expect(updated.isFavorite, isTrue);
      expect(updated.readingProgress, 0.4);
      expect(updated.titre, letter.titre);
    });
  });
}
