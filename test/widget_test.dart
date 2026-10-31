import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:amabaruwa/app/providers.dart';
import 'package:amabaruwa/core/database/app_database.dart';
import 'package:amabaruwa/core/theme/kinyarwanda_localizations.dart';
import 'package:amabaruwa/features/home/home_screen.dart';
import 'package:amabaruwa/features/letters/models/daily_word.dart';
import 'package:amabaruwa/features/letters/models/letter.dart';
import 'package:amabaruwa/features/letters/widgets/letter_card.dart';
import 'package:amabaruwa/l10n/app_localizations.dart';
import 'package:amabaruwa/shared/widgets/state_views.dart';

void main() {
  testWidgets('premier lancement hors ligne, grande taille de texte', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          lettersProvider.overrideWith((ref) => Stream.value(const <Letter>[])),
          dailyWordsProvider.overrideWith(
            (ref) => Stream.value(const <DailyWord>[]),
          ),
          downloadJobsProvider.overrideWith(
            (ref) => Stream.value(const <DownloadJob>[]),
          ),
          connectivityProvider.overrideWith((ref) => Stream.value(false)),
        ],
        child: MaterialApp(
          locale: const Locale('rw'),
          supportedLocales: const [Locale('rw')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            KinyarwandaMaterialLocalizationsDelegate(),
            DefaultWidgetsLocalizations.delegate,
            KinyarwandaCupertinoLocalizationsDelegate(),
          ],
          home: const MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(2)),
            child: HomeScreen(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(OfflineBanner), findsOneWidget);
    expect(find.byType(EmptyState), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('carte de lettre robuste en grande taille de texte', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const letter = Letter(
      id: 'l1',
      numero: 1,
      slug: 'ibaruwa-ya-mbere',
      langue: 'rw',
      titre: 'Ibaruwa ya mbere y’urugero rurerure',
      contenuHtml:
          '<p>Uru ni urugero rw’inyandiko ndende kugira ngo duhitemo '
          'imipaka y’umurongo n’imiterere y’ikarita.</p>',
      statut: 'publie',
      pdfUrl: 'https://example.test/f.pdf',
      audioUrl: 'https://example.test/a.mp3',
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('rw'),
        supportedLocales: const [Locale('rw')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          KinyarwandaMaterialLocalizationsDelegate(),
          DefaultWidgetsLocalizations.delegate,
          KinyarwandaCupertinoLocalizationsDelegate(),
        ],
        home: const MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(2)),
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16),
              child: LetterCard(
                letter: letter,
                onTap: _noop,
                onFavorite: _noop,
                pdfOffline: true,
                audioOffline: true,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(letter.titre), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

void _noop() {}
