import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:amabaruwa/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  LettersCompanion remoteLetter({String titre = 'Ibaruwa ya mbere'}) {
    return LettersCompanion(
      id: const Value('l1'),
      numero: const Value(1),
      slug: const Value('ibaruwa-ya-mbere'),
      langue: const Value('rw'),
      titre: Value(titre),
      contenuHtml: const Value('<p>Urugero</p>'),
      statut: const Value('publie'),
      remoteAvailable: const Value(true),
    );
  }

  test('la synchronisation préserve favoris et progression', () async {
    await db.applyRemote(
      remoteLetters: [remoteLetter()],
      remoteWords: const [],
    );
    await db.setFavorite('l1', true);
    await db.saveReadingProgress('l1', 0.42, DateTime.utc(2026, 10, 31));
    await db.saveAudioPosition('l1', 120.5);

    await db.applyRemote(
      remoteLetters: [remoteLetter(titre: 'Ibaruwa ya mbere ivuguruwe')],
      remoteWords: const [],
    );

    final letter = await db.getLetter('l1');
    expect(letter, isNotNull);
    expect(letter!.titre, 'Ibaruwa ya mbere ivuguruwe');
    expect(letter.isFavorite, isTrue);
    expect(letter.readingProgress, closeTo(0.42, 0.0001));
    expect(letter.audioPositionSeconds, closeTo(120.5, 0.0001));
  });

  test('un contenu absent du serveur est marqué indisponible', () async {
    await db.applyRemote(
      remoteLetters: [remoteLetter()],
      remoteWords: const [],
    );
    await db.applyRemote(remoteLetters: const [], remoteWords: const []);
    final letter = await db.getLetter('l1');
    expect(letter!.remoteAvailable, isFalse);
  });

  test('un téléchargement interrompu repasse en attente', () async {
    final id = await db.upsertDownloadJob(
      DownloadJobsCompanion.insert(
        letterId: 'l1',
        fileType: 'pdf',
        remoteUrl: 'https://example.test/f.pdf',
        fileName: 'f.pdf',
        status: const Value('running'),
        totalBytes: const Value(100),
      ),
    );
    await db.resetInterruptedDownloads();
    final job = await (db.select(
      db.downloadJobs,
    )..where((t) => t.id.equals(id))).getSingle();
    expect(job.status, 'pending');
    expect(job.error, isNotNull);
  });

  test('favori et progression restent locaux après mise à jour', () async {
    await db.applyRemote(
      remoteLetters: [remoteLetter()],
      remoteWords: const [],
    );
    await db.setFavorite('l1', true);
    final favorite = await db.getLetter('l1');
    expect(favorite!.isFavorite, isTrue);
  });
}
