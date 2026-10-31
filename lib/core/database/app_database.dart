import 'package:drift/drift.dart';

part 'app_database.g.dart';

@DataClassName('LetterRow')
class Letters extends Table {
  TextColumn get id => text()();
  IntColumn get numero => integer()();
  TextColumn get slug => text()();
  TextColumn get langue => text().withDefault(const Constant('rw'))();
  TextColumn get titre => text()();
  TextColumn get contenuHtml => text().withDefault(const Constant(''))();
  TextColumn get statut => text().withDefault(const Constant('publie'))();
  TextColumn get pdfFile => text().nullable()();
  TextColumn get pdfUrl => text().nullable()();
  TextColumn get audioFile => text().nullable()();
  TextColumn get audioUrl => text().nullable()();
  TextColumn get urlOrigine => text().nullable()();
  TextColumn get sourceKey => text().nullable()();
  TextColumn get pdfSha256 => text().nullable()();
  TextColumn get audioSha256 => text().nullable()();
  DateTimeColumn get sourceModifiedAt => dateTime().nullable()();
  IntColumn get pdfSizeBytes => integer().nullable()();
  IntColumn get audioSizeBytes => integer().nullable()();
  RealColumn get audioDurationSeconds => real().nullable()();
  RealColumn get audioPositionSeconds =>
      real().withDefault(const Constant(0))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  RealColumn get readingProgress => real().withDefault(const Constant(0))();
  DateTimeColumn get lastReadAt => dateTime().nullable()();
  BoolColumn get remoteAvailable =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get localUpdatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DailyWordRow')
class DailyWords extends Table {
  TextColumn get id => text()();
  TextColumn get dateLocale => text()();
  TextColumn get langue => text().withDefault(const Constant('rw'))();
  TextColumn get titre => text()();
  TextColumn get citation => text()();
  TextColumn get referenceSource => text()();
  TextColumn get lettreLieeId => text().nullable()();
  TextColumn get audioExtraitUrl => text().nullable()();
  TextColumn get sourceKey => text()();
  TextColumn get statut => text().withDefault(const Constant('publie'))();
  BoolColumn get remoteAvailable =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('DownloadJob')
class DownloadJobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get letterId => text()();
  TextColumn get fileType => text()();
  TextColumn get remoteUrl => text()();
  TextColumn get fileName => text()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get bytesReceived => integer().withDefault(const Constant(0))();
  IntColumn get totalBytes => integer().nullable()();
  TextColumn get sha256 => text().nullable()();
  TextColumn get localPath => text().nullable()();
  TextColumn get error => text().nullable()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {letterId, fileType},
  ];
}

@DriftDatabase(tables: [Letters, DailyWords, DownloadJobs])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  Stream<List<LetterRow>> watchLetters() {
    return (select(
      letters,
    )..orderBy([(t) => OrderingTerm.asc(t.numero)])).watch();
  }

  Stream<LetterRow?> watchLetter(String id) {
    return (select(letters)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<LetterRow?> getLetter(String id) {
    return (select(letters)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<List<DailyWordRow>> watchDailyWords() {
    return (select(
      dailyWords,
    )..orderBy([(t) => OrderingTerm.desc(t.dateLocale)])).watch();
  }

  Future<void> setFavorite(String id, bool favorite) async {
    await (update(letters)..where((t) => t.id.equals(id))).write(
      LettersCompanion(
        isFavorite: Value(favorite),
        localUpdatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> saveReadingProgress(
    String id,
    double progress,
    DateTime readAt,
  ) async {
    await (update(letters)..where((t) => t.id.equals(id))).write(
      LettersCompanion(
        readingProgress: Value(progress.clamp(0, 1)),
        lastReadAt: Value(readAt.toUtc()),
        localUpdatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> saveAudioPosition(String id, double seconds) async {
    await (update(letters)..where((t) => t.id.equals(id))).write(
      LettersCompanion(
        audioPositionSeconds: Value(seconds),
        localUpdatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> applyRemote({
    required List<LettersCompanion> remoteLetters,
    required List<DailyWordsCompanion> remoteWords,
  }) async {
    await transaction(() async {
      for (final companion in remoteLetters) {
        await into(letters).insertOnConflictUpdate(companion);
      }
      for (final companion in remoteWords) {
        await into(dailyWords).insertOnConflictUpdate(companion);
      }

      final remoteIds = remoteLetters.map((c) => c.id.value).toSet();
      final localLetters = await select(letters).get();
      for (final local in localLetters) {
        final available = remoteIds.contains(local.id);
        if (local.remoteAvailable != available) {
          await (update(letters)..where((t) => t.id.equals(local.id))).write(
            LettersCompanion(remoteAvailable: Value(available)),
          );
        }
      }

      final remoteWordIds = remoteWords.map((c) => c.id.value).toSet();
      final localWords = await select(dailyWords).get();
      for (final local in localWords) {
        final available = remoteWordIds.contains(local.id);
        if (local.remoteAvailable != available) {
          await (update(dailyWords)..where((t) => t.id.equals(local.id))).write(
            DailyWordsCompanion(remoteAvailable: Value(available)),
          );
        }
      }
    });
  }

  Stream<List<DownloadJob>> watchDownloadJobs() {
    return (select(
      downloadJobs,
    )..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])).watch();
  }

  Future<DownloadJob?> findDownloadJob(String letterId, String fileType) {
    return (select(downloadJobs)
          ..where((t) => t.letterId.equals(letterId))
          ..where((t) => t.fileType.equals(fileType)))
        .getSingleOrNull();
  }

  Future<int> upsertDownloadJob(DownloadJobsCompanion companion) {
    return into(downloadJobs).insertOnConflictUpdate(companion);
  }

  Future<void> updateDownloadJob(
    int id,
    DownloadJobsCompanion companion,
  ) async {
    await (update(downloadJobs)..where((t) => t.id.equals(id))).write(
      companion.copyWith(updatedAt: Value(DateTime.now().toUtc())),
    );
  }

  Future<void> deleteDownloadJob(int id) async {
    await (delete(downloadJobs)..where((t) => t.id.equals(id))).go();
  }

  Future<List<DownloadJob>> pendingDownloadJobs() {
    return (select(downloadJobs)
          ..where(
            (t) => t.status.equals('pending') | t.status.equals('running'),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<void> resetInterruptedDownloads() async {
    await (update(
      downloadJobs,
    )..where((t) => t.status.equals('running'))).write(
      const DownloadJobsCompanion(
        status: Value('pending'),
        error: Value('Gukurura byahagaritswe. Ongera ugerageze.'),
      ),
    );
  }
}
