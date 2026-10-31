import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/app_config.dart';

class SettingsState {
  const SettingsState({
    required this.themeMode,
    required this.fontSize,
    this.lastSync,
  });

  final ThemeMode themeMode;
  final double fontSize;
  final DateTime? lastSync;

  SettingsState copyWith({
    ThemeMode? themeMode,
    double? fontSize,
    DateTime? lastSync,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      fontSize: fontSize ?? this.fontSize,
      lastSync: lastSync ?? this.lastSync,
    );
  }
}

class SettingsController extends Notifier<SettingsState> {
  static const _themeKey = 'theme_mode';
  static const _fontKey = 'reading_font_size';
  static const _lastSyncKey = 'last_sync';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  SettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final theme = prefs.getString(_themeKey) ?? 'system';
    final fontSize = prefs.getDouble(_fontKey) ?? AppConfig.defaultFontSize;
    final lastSyncRaw = prefs.getString(_lastSyncKey);
    return SettingsState(
      themeMode: switch (theme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
      fontSize: _clampFont(fontSize),
      lastSync: lastSyncRaw == null ? null : DateTime.tryParse(lastSyncRaw),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_themeKey, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setFontSize(double size) async {
    final value = _clampFont(size);
    await _prefs.setDouble(_fontKey, value);
    state = state.copyWith(fontSize: value);
  }

  Future<void> increaseFont() => setFontSize(state.fontSize + 2);

  Future<void> decreaseFont() => setFontSize(state.fontSize - 2);

  Future<void> markSynced(DateTime date) async {
    await _prefs.setString(_lastSyncKey, date.toUtc().toIso8601String());
    state = state.copyWith(lastSync: date.toUtc());
  }

  static double _clampFont(double value) {
    if (value < AppConfig.minFontSize) {
      return AppConfig.minFontSize;
    }
    if (value > AppConfig.maxFontSize) {
      return AppConfig.maxFontSize;
    }
    return value;
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharedPreferences non initialisé.'),
);

final settingsControllerProvider =
    NotifierProvider<SettingsController, SettingsState>(SettingsController.new);
