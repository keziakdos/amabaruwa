import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:amabaruwa/core/downloads/download_service.dart';

void main() {
  test('accepte un fichier complet avec la bonne empreinte', () async {
    final file = File('${Directory.systemTemp.path}/amabaruwa-ok.bin');
    await file.writeAsBytes(List<int>.generate(1024, (i) => i % 256));
    final digest = await computeSha256File(file);
    expect(
      await verifyFileIntegrity(
        file,
        expectedSize: 1024,
        expectedSha256: digest,
      ),
      isTrue,
    );
    await file.delete();
  });

  test('refuse un fichier incomplet', () async {
    final file = File('${Directory.systemTemp.path}/amabaruwa-short.bin');
    await file.writeAsBytes([1, 2, 3, 4]);
    expect(await verifyFileIntegrity(file, expectedSize: 10), isFalse);
    await file.delete();
  });

  test('refuse une empreinte incorrecte', () async {
    final file = File('${Directory.systemTemp.path}/amabaruwa-hash.bin');
    await file.writeAsBytes([1, 2, 3, 4]);
    expect(await verifyFileIntegrity(file, expectedSha256: '0' * 64), isFalse);
    await file.delete();
  });

  test('refuse un fichier absent', () async {
    final file = File('${Directory.systemTemp.path}/amabaruwa-absent.bin');
    expect(await verifyFileIntegrity(file), isFalse);
  });
}
