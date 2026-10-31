import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/network/pocketbase_gateway.dart';
import '../../settings/settings_controller.dart';

class SyncState {
  const SyncState({
    this.syncing = false,
    this.lastSync,
    this.error,
    this.lastLetters = 0,
    this.lastWords = 0,
  });

  final bool syncing;
  final DateTime? lastSync;
  final String? error;
  final int lastLetters;
  final int lastWords;

  SyncState copyWith({
    bool? syncing,
    DateTime? lastSync,
    String? error,
    int? lastLetters,
    int? lastWords,
  }) {
    return SyncState(
      syncing: syncing ?? this.syncing,
      lastSync: lastSync ?? this.lastSync,
      error: error,
      lastLetters: lastLetters ?? this.lastLetters,
      lastWords: lastWords ?? this.lastWords,
    );
  }
}

class SyncController extends Notifier<SyncState> {
  @override
  SyncState build() {
    final settings = ref.watch(settingsControllerProvider);
    return SyncState(lastSync: settings.lastSync);
  }

  Future<bool> syncNow() async {
    if (state.syncing) {
      return false;
    }
    state = state.copyWith(syncing: true, error: null);
    try {
      final result = await ref.read(lettersRepositoryProvider).sync();
      await ref
          .read(settingsControllerProvider.notifier)
          .markSynced(result.syncedAt);
      state = SyncState(
        lastSync: result.syncedAt,
        lastLetters: result.letters,
        lastWords: result.dailyWords,
      );
      return true;
    } on NetworkException catch (error) {
      state = state.copyWith(syncing: false, error: error.message);
      return false;
    } catch (_) {
      state = state.copyWith(syncing: false, error: 'Guhuza amakuru byanze.');
      return false;
    }
  }
}

final syncControllerProvider = NotifierProvider<SyncController, SyncState>(
  SyncController.new,
);
