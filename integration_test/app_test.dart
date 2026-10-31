import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amabaruwa/app/app.dart';
import 'package:amabaruwa/app/providers.dart';
import 'package:amabaruwa/core/database/app_database.dart';
import 'package:amabaruwa/features/letters/models/daily_word.dart';
import 'package:amabaruwa/features/letters/models/letter.dart';
import 'package:amabaruwa/features/settings/settings_controller.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigation principale avec données locales vides', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          lettersProvider.overrideWith((ref) => Stream.value(const <Letter>[])),
          dailyWordsProvider.overrideWith(
            (ref) => Stream.value(const <DailyWord>[]),
          ),
          downloadJobsProvider.overrideWith(
            (ref) => Stream.value(const <DownloadJob>[]),
          ),
          connectivityProvider.overrideWith((ref) => Stream.value(false)),
        ],
        child: const AmabaruwaApp(),
      ),
    );
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    expect(find.text('Ahabanza'), findsOneWidget);
    expect(find.text('Amabaruwa'), findsWidgets);
    expect(find.text('Ibikururwa'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu_book_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Shakisha ku izina cyangwa nimero'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.download_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Nta dosiye zirakururwa.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home_outlined));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });
}
