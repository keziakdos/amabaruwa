import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/pocketbase_gateway.dart';
import '../models/daily_word.dart';
import '../models/letter.dart';

class SyncOutcome {
  const SyncOutcome({
    required this.letters,
    required this.dailyWords,
    required this.syncedAt,
  });

  final int letters;
  final int dailyWords;
  final DateTime syncedAt;
}

class LettersRepository {
  LettersRepository({required this.db, required this.gateway});

  final AppDatabase db;
  final PocketBaseGateway gateway;

  Stream<List<Letter>> watchLetters() {
    return db.watchLetters().map((rows) => rows.map(_toLetter).toList());
  }

  Stream<List<DailyWord>> watchDailyWords() {
    return db.watchDailyWords().map((rows) => rows.map(_toDailyWord).toList());
  }

  Stream<Letter?> watchLetter(String id) {
    return db.watchLetter(id).map((row) => row == null ? null : _toLetter(row));
  }

  Future<Letter?> getLetter(String id) async {
    final row = await db.getLetter(id);
    return row == null ? null : _toLetter(row);
  }

  Future<SyncOutcome> sync() async {
    final remoteLetters = await gateway.fetchLetters();
    final remoteWords = await gateway.fetchDailyWords();

    await db.applyRemote(
      remoteLetters: remoteLetters.map(_toLetterCompanion).toList(),
      remoteWords: remoteWords.map(_toDailyWordCompanion).toList(),
    );

    return SyncOutcome(
      letters: remoteLetters.length,
      dailyWords: remoteWords.length,
      syncedAt: DateTime.now().toUtc(),
    );
  }

  Future<void> toggleFavorite(String id, {required bool favorite}) {
    return db.setFavorite(id, favorite);
  }

  Future<void> saveReadingProgress(String id, double progress) {
    return db.saveReadingProgress(id, progress, DateTime.now());
  }

  Future<void> saveAudioPosition(String id, double seconds) {
    return db.saveAudioPosition(id, seconds);
  }

  Letter _toLetter(LetterRow row) {
    return Letter(
      id: row.id,
      numero: row.numero,
      slug: row.slug,
      langue: row.langue,
      titre: row.titre,
      contenuHtml: row.contenuHtml,
      statut: row.statut,
      pdfFile: row.pdfFile,
      pdfUrl: row.pdfUrl,
      audioFile: row.audioFile,
      audioUrl: row.audioUrl,
      urlOrigine: row.urlOrigine,
      sourceKey: row.sourceKey,
      pdfSha256: row.pdfSha256,
      audioSha256: row.audioSha256,
      sourceModifiedAt: row.sourceModifiedAt,
      pdfSizeBytes: row.pdfSizeBytes,
      audioSizeBytes: row.audioSizeBytes,
      audioDurationSeconds: row.audioDurationSeconds,
      audioPositionSeconds: row.audioPositionSeconds,
      isFavorite: row.isFavorite,
      readingProgress: row.readingProgress,
      lastReadAt: row.lastReadAt,
      remoteAvailable: row.remoteAvailable,
    );
  }

  DailyWord _toDailyWord(DailyWordRow row) {
    return DailyWord(
      id: row.id,
      dateLocale: row.dateLocale,
      langue: row.langue,
      titre: row.titre,
      citation: row.citation,
      referenceSource: row.referenceSource,
      lettreLieeId: row.lettreLieeId,
      audioExtraitUrl: row.audioExtraitUrl,
      sourceKey: row.sourceKey,
      statut: row.statut,
      remoteAvailable: row.remoteAvailable,
    );
  }

  LettersCompanion _toLetterCompanion(Letter letter) {
    return LettersCompanion(
      id: Value(letter.id),
      numero: Value(letter.numero),
      slug: Value(letter.slug),
      langue: Value(letter.langue),
      titre: Value(letter.titre),
      contenuHtml: Value(letter.contenuHtml),
      statut: Value(letter.statut),
      pdfFile: Value(letter.pdfFile),
      pdfUrl: Value(letter.pdfUrl),
      audioFile: Value(letter.audioFile),
      audioUrl: Value(letter.audioUrl),
      urlOrigine: Value(letter.urlOrigine),
      sourceKey: Value(letter.sourceKey),
      pdfSha256: Value(letter.pdfSha256),
      audioSha256: Value(letter.audioSha256),
      sourceModifiedAt: Value(letter.sourceModifiedAt),
      pdfSizeBytes: Value(letter.pdfSizeBytes),
      audioSizeBytes: Value(letter.audioSizeBytes),
      audioDurationSeconds: Value(letter.audioDurationSeconds),
      remoteAvailable: const Value(true),
    );
  }

  DailyWordsCompanion _toDailyWordCompanion(DailyWord word) {
    return DailyWordsCompanion(
      id: Value(word.id),
      dateLocale: Value(word.dateLocale),
      langue: Value(word.langue),
      titre: Value(word.titre),
      citation: Value(word.citation),
      referenceSource: Value(word.referenceSource),
      lettreLieeId: Value(word.lettreLieeId),
      audioExtraitUrl: Value(word.audioExtraitUrl),
      sourceKey: Value(word.sourceKey),
      statut: Value(word.statut),
      remoteAvailable: const Value(true),
    );
  }
}
