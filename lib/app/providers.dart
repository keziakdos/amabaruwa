import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/audio/audio_service.dart';
import '../core/database/app_database.dart';
import '../core/downloads/download_service.dart';
import '../core/network/pocketbase_gateway.dart';
import '../core/utils/kigali_date.dart';
import '../features/daily_word/daily_word_selector.dart';
import '../features/letters/data/letters_repository.dart';
import '../features/letters/models/daily_word.dart';
import '../features/letters/models/letter.dart';
import '../features/settings/settings_controller.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase(driftDatabase(name: 'amabaruwa'));
  ref.onDispose(database.close);
  return database;
});

final gatewayProvider = Provider<PocketBaseGateway>((ref) {
  return PocketBaseGateway();
});

final lettersRepositoryProvider = Provider<LettersRepository>((ref) {
  return LettersRepository(
    db: ref.watch(databaseProvider),
    gateway: ref.watch(gatewayProvider),
  );
});

final lettersProvider = StreamProvider<List<Letter>>((ref) {
  return ref.watch(lettersRepositoryProvider).watchLetters();
});

final letterProvider = StreamProvider.family<Letter?, String>((ref, id) {
  return ref.watch(lettersRepositoryProvider).watchLetter(id);
});

final dailyWordsProvider = StreamProvider<List<DailyWord>>((ref) {
  return ref.watch(lettersRepositoryProvider).watchDailyWords();
});

final dailyWordSelectionProvider = Provider<DailyWordSelection?>((ref) {
  final words = ref.watch(dailyWordsProvider);
  return words.maybeWhen(
    data: (value) => selectDailyWord(value, now: kigaliNow()),
    orElse: () => null,
  );
});

final connectivityProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  final initial = await connectivity.checkConnectivity();
  yield !initial.contains(ConnectivityResult.none);
  yield* connectivity.onConnectivityChanged.map(
    (results) => !results.contains(ConnectivityResult.none),
  );
});

final downloadServiceProvider = Provider<DownloadService>((ref) {
  final service = DownloadService(ref.watch(databaseProvider));
  unawaited(service.initialize());
  return service;
});

final audioServiceProvider = Provider<AudioService>((ref) {
  final service = AudioService(ref.watch(databaseProvider));
  ref.onDispose(service.dispose);
  return service;
});

final downloadJobsProvider = StreamProvider<List<DownloadJob>>((ref) {
  return ref.watch(downloadServiceProvider).watchJobs();
});

final settingsStateProvider = Provider((ref) {
  return ref.watch(settingsControllerProvider);
});
