class AppConfig {
  const AppConfig._();

  /// URL de production, surchargeable pour les tests :
  /// flutter run --dart-define=PB_URL=http://127.0.0.1:8095
  static const String baseUrl = String.fromEnvironment(
    'PB_URL',
    defaultValue: 'https://amabaruwa.rwazap.com',
  );

  static const String sourceSite = 'https://www.inzirayakristu.com';
  static const String sourceName = 'inzirayakristu.com';

  static const String appVersion = '1.0.0';

  static const double minFontSize = 14;
  static const double defaultFontSize = 18;
  static const double maxFontSize = 26;

  static const List<double> fontSizeSteps = [14, 16, 18, 20, 22, 24, 26];
}
