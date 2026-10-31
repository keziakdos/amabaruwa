import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../core/theme/kinyarwanda_localizations.dart';
import '../features/settings/settings_controller.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';

class AmabaruwaApp extends ConsumerWidget {
  const AmabaruwaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Amabaruwa',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: settings.themeMode,
      locale: const Locale('rw'),
      supportedLocales: const [Locale('rw')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        KinyarwandaMaterialLocalizationsDelegate(),
        GlobalWidgetsLocalizations.delegate,
        KinyarwandaCupertinoLocalizationsDelegate(),
      ],
      routerConfig: router,
    );
  }
}
