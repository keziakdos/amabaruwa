// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LettersTable extends Letters with TableInfo<$LettersTable, LetterRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LettersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<int> numero = GeneratedColumn<int>(
    'numero',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _langueMeta = const VerificationMeta('langue');
  @override
  late final GeneratedColumn<String> langue = GeneratedColumn<String>(
    'langue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('rw'),
  );
  static const VerificationMeta _titreMeta = const VerificationMeta('titre');
  @override
  late final GeneratedColumn<String> titre = GeneratedColumn<String>(
    'titre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contenuHtmlMeta = const VerificationMeta(
    'contenuHtml',
  );
  @override
  late final GeneratedColumn<String> contenuHtml = GeneratedColumn<String>(
    'contenu_html',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('publie'),
  );
  static const VerificationMeta _pdfFileMeta = const VerificationMeta(
    'pdfFile',
  );
  @override
  late final GeneratedColumn<String> pdfFile = GeneratedColumn<String>(
    'pdf_file',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pdfUrlMeta = const VerificationMeta('pdfUrl');
  @override
  late final GeneratedColumn<String> pdfUrl = GeneratedColumn<String>(
    'pdf_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioFileMeta = const VerificationMeta(
    'audioFile',
  );
  @override
  late final GeneratedColumn<String> audioFile = GeneratedColumn<String>(
    'audio_file',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlOrigineMeta = const VerificationMeta(
    'urlOrigine',
  );
  @override
  late final GeneratedColumn<String> urlOrigine = GeneratedColumn<String>(
    'url_origine',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceKeyMeta = const VerificationMeta(
    'sourceKey',
  );
  @override
  late final GeneratedColumn<String> sourceKey = GeneratedColumn<String>(
    'source_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pdfSha256Meta = const VerificationMeta(
    'pdfSha256',
  );
  @override
  late final GeneratedColumn<String> pdfSha256 = GeneratedColumn<String>(
    'pdf_sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioSha256Meta = const VerificationMeta(
    'audioSha256',
  );
  @override
  late final GeneratedColumn<String> audioSha256 = GeneratedColumn<String>(
    'audio_sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceModifiedAtMeta = const VerificationMeta(
    'sourceModifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> sourceModifiedAt =
      GeneratedColumn<DateTime>(
        'source_modified_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _pdfSizeBytesMeta = const VerificationMeta(
    'pdfSizeBytes',
  );
  @override
  late final GeneratedColumn<int> pdfSizeBytes = GeneratedColumn<int>(
    'pdf_size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioSizeBytesMeta = const VerificationMeta(
    'audioSizeBytes',
  );
  @override
  late final GeneratedColumn<int> audioSizeBytes = GeneratedColumn<int>(
    'audio_size_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioDurationSecondsMeta =
      const VerificationMeta('audioDurationSeconds');
  @override
  late final GeneratedColumn<double> audioDurationSeconds =
      GeneratedColumn<double>(
        'audio_duration_seconds',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _audioPositionSecondsMeta =
      const VerificationMeta('audioPositionSeconds');
  @override
  late final GeneratedColumn<double> audioPositionSeconds =
      GeneratedColumn<double>(
        'audio_position_seconds',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _readingProgressMeta = const VerificationMeta(
    'readingProgress',
  );
  @override
  late final GeneratedColumn<double> readingProgress = GeneratedColumn<double>(
    'reading_progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReadAtMeta = const VerificationMeta(
    'lastReadAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReadAt = GeneratedColumn<DateTime>(
    'last_read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteAvailableMeta = const VerificationMeta(
    'remoteAvailable',
  );
  @override
  late final GeneratedColumn<bool> remoteAvailable = GeneratedColumn<bool>(
    'remote_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remote_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _localUpdatedAtMeta = const VerificationMeta(
    'localUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> localUpdatedAt =
      GeneratedColumn<DateTime>(
        'local_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    numero,
    slug,
    langue,
    titre,
    contenuHtml,
    statut,
    pdfFile,
    pdfUrl,
    audioFile,
    audioUrl,
    urlOrigine,
    sourceKey,
    pdfSha256,
    audioSha256,
    sourceModifiedAt,
    pdfSizeBytes,
    audioSizeBytes,
    audioDurationSeconds,
    audioPositionSeconds,
    isFavorite,
    readingProgress,
    lastReadAt,
    remoteAvailable,
    localUpdatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'letters';
  @override
  VerificationContext validateIntegrity(
    Insertable<LetterRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('langue')) {
      context.handle(
        _langueMeta,
        langue.isAcceptableOrUnknown(data['langue']!, _langueMeta),
      );
    }
    if (data.containsKey('titre')) {
      context.handle(
        _titreMeta,
        titre.isAcceptableOrUnknown(data['titre']!, _titreMeta),
      );
    } else if (isInserting) {
      context.missing(_titreMeta);
    }
    if (data.containsKey('contenu_html')) {
      context.handle(
        _contenuHtmlMeta,
        contenuHtml.isAcceptableOrUnknown(
          data['contenu_html']!,
          _contenuHtmlMeta,
        ),
      );
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('pdf_file')) {
      context.handle(
        _pdfFileMeta,
        pdfFile.isAcceptableOrUnknown(data['pdf_file']!, _pdfFileMeta),
      );
    }
    if (data.containsKey('pdf_url')) {
      context.handle(
        _pdfUrlMeta,
        pdfUrl.isAcceptableOrUnknown(data['pdf_url']!, _pdfUrlMeta),
      );
    }
    if (data.containsKey('audio_file')) {
      context.handle(
        _audioFileMeta,
        audioFile.isAcceptableOrUnknown(data['audio_file']!, _audioFileMeta),
      );
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    }
    if (data.containsKey('url_origine')) {
      context.handle(
        _urlOrigineMeta,
        urlOrigine.isAcceptableOrUnknown(data['url_origine']!, _urlOrigineMeta),
      );
    }
    if (data.containsKey('source_key')) {
      context.handle(
        _sourceKeyMeta,
        sourceKey.isAcceptableOrUnknown(data['source_key']!, _sourceKeyMeta),
      );
    }
    if (data.containsKey('pdf_sha256')) {
      context.handle(
        _pdfSha256Meta,
        pdfSha256.isAcceptableOrUnknown(data['pdf_sha256']!, _pdfSha256Meta),
      );
    }
    if (data.containsKey('audio_sha256')) {
      context.handle(
        _audioSha256Meta,
        audioSha256.isAcceptableOrUnknown(
          data['audio_sha256']!,
          _audioSha256Meta,
        ),
      );
    }
    if (data.containsKey('source_modified_at')) {
      context.handle(
        _sourceModifiedAtMeta,
        sourceModifiedAt.isAcceptableOrUnknown(
          data['source_modified_at']!,
          _sourceModifiedAtMeta,
        ),
      );
    }
    if (data.containsKey('pdf_size_bytes')) {
      context.handle(
        _pdfSizeBytesMeta,
        pdfSizeBytes.isAcceptableOrUnknown(
          data['pdf_size_bytes']!,
          _pdfSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('audio_size_bytes')) {
      context.handle(
        _audioSizeBytesMeta,
        audioSizeBytes.isAcceptableOrUnknown(
          data['audio_size_bytes']!,
          _audioSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('audio_duration_seconds')) {
      context.handle(
        _audioDurationSecondsMeta,
        audioDurationSeconds.isAcceptableOrUnknown(
          data['audio_duration_seconds']!,
          _audioDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('audio_position_seconds')) {
      context.handle(
        _audioPositionSecondsMeta,
        audioPositionSeconds.isAcceptableOrUnknown(
          data['audio_position_seconds']!,
          _audioPositionSecondsMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('reading_progress')) {
      context.handle(
        _readingProgressMeta,
        readingProgress.isAcceptableOrUnknown(
          data['reading_progress']!,
          _readingProgressMeta,
        ),
      );
    }
    if (data.containsKey('last_read_at')) {
      context.handle(
        _lastReadAtMeta,
        lastReadAt.isAcceptableOrUnknown(
          data['last_read_at']!,
          _lastReadAtMeta,
        ),
      );
    }
    if (data.containsKey('remote_available')) {
      context.handle(
        _remoteAvailableMeta,
        remoteAvailable.isAcceptableOrUnknown(
          data['remote_available']!,
          _remoteAvailableMeta,
        ),
      );
    }
    if (data.containsKey('local_updated_at')) {
      context.handle(
        _localUpdatedAtMeta,
        localUpdatedAt.isAcceptableOrUnknown(
          data['local_updated_at']!,
          _localUpdatedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LetterRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LetterRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      langue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}langue'],
      )!,
      titre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titre'],
      )!,
      contenuHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contenu_html'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      pdfFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_file'],
      ),
      pdfUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_url'],
      ),
      audioFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_file'],
      ),
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      ),
      urlOrigine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url_origine'],
      ),
      sourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_key'],
      ),
      pdfSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_sha256'],
      ),
      audioSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_sha256'],
      ),
      sourceModifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}source_modified_at'],
      ),
      pdfSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pdf_size_bytes'],
      ),
      audioSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}audio_size_bytes'],
      ),
      audioDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}audio_duration_seconds'],
      ),
      audioPositionSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}audio_position_seconds'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      readingProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}reading_progress'],
      )!,
      lastReadAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_read_at'],
      ),
      remoteAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remote_available'],
      )!,
      localUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_updated_at'],
      )!,
    );
  }

  @override
  $LettersTable createAlias(String alias) {
    return $LettersTable(attachedDatabase, alias);
  }
}

class LetterRow extends DataClass implements Insertable<LetterRow> {
  final String id;
  final int numero;
  final String slug;
  final String langue;
  final String titre;
  final String contenuHtml;
  final String statut;
  final String? pdfFile;
  final String? pdfUrl;
  final String? audioFile;
  final String? audioUrl;
  final String? urlOrigine;
  final String? sourceKey;
  final String? pdfSha256;
  final String? audioSha256;
  final DateTime? sourceModifiedAt;
  final int? pdfSizeBytes;
  final int? audioSizeBytes;
  final double? audioDurationSeconds;
  final double audioPositionSeconds;
  final bool isFavorite;
  final double readingProgress;
  final DateTime? lastReadAt;
  final bool remoteAvailable;
  final DateTime localUpdatedAt;
  const LetterRow({
    required this.id,
    required this.numero,
    required this.slug,
    required this.langue,
    required this.titre,
    required this.contenuHtml,
    required this.statut,
    this.pdfFile,
    this.pdfUrl,
    this.audioFile,
    this.audioUrl,
    this.urlOrigine,
    this.sourceKey,
    this.pdfSha256,
    this.audioSha256,
    this.sourceModifiedAt,
    this.pdfSizeBytes,
    this.audioSizeBytes,
    this.audioDurationSeconds,
    required this.audioPositionSeconds,
    required this.isFavorite,
    required this.readingProgress,
    this.lastReadAt,
    required this.remoteAvailable,
    required this.localUpdatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['numero'] = Variable<int>(numero);
    map['slug'] = Variable<String>(slug);
    map['langue'] = Variable<String>(langue);
    map['titre'] = Variable<String>(titre);
    map['contenu_html'] = Variable<String>(contenuHtml);
    map['statut'] = Variable<String>(statut);
    if (!nullToAbsent || pdfFile != null) {
      map['pdf_file'] = Variable<String>(pdfFile);
    }
    if (!nullToAbsent || pdfUrl != null) {
      map['pdf_url'] = Variable<String>(pdfUrl);
    }
    if (!nullToAbsent || audioFile != null) {
      map['audio_file'] = Variable<String>(audioFile);
    }
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    if (!nullToAbsent || urlOrigine != null) {
      map['url_origine'] = Variable<String>(urlOrigine);
    }
    if (!nullToAbsent || sourceKey != null) {
      map['source_key'] = Variable<String>(sourceKey);
    }
    if (!nullToAbsent || pdfSha256 != null) {
      map['pdf_sha256'] = Variable<String>(pdfSha256);
    }
    if (!nullToAbsent || audioSha256 != null) {
      map['audio_sha256'] = Variable<String>(audioSha256);
    }
    if (!nullToAbsent || sourceModifiedAt != null) {
      map['source_modified_at'] = Variable<DateTime>(sourceModifiedAt);
    }
    if (!nullToAbsent || pdfSizeBytes != null) {
      map['pdf_size_bytes'] = Variable<int>(pdfSizeBytes);
    }
    if (!nullToAbsent || audioSizeBytes != null) {
      map['audio_size_bytes'] = Variable<int>(audioSizeBytes);
    }
    if (!nullToAbsent || audioDurationSeconds != null) {
      map['audio_duration_seconds'] = Variable<double>(audioDurationSeconds);
    }
    map['audio_position_seconds'] = Variable<double>(audioPositionSeconds);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['reading_progress'] = Variable<double>(readingProgress);
    if (!nullToAbsent || lastReadAt != null) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt);
    }
    map['remote_available'] = Variable<bool>(remoteAvailable);
    map['local_updated_at'] = Variable<DateTime>(localUpdatedAt);
    return map;
  }

  LettersCompanion toCompanion(bool nullToAbsent) {
    return LettersCompanion(
      id: Value(id),
      numero: Value(numero),
      slug: Value(slug),
      langue: Value(langue),
      titre: Value(titre),
      contenuHtml: Value(contenuHtml),
      statut: Value(statut),
      pdfFile: pdfFile == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfFile),
      pdfUrl: pdfUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfUrl),
      audioFile: audioFile == null && nullToAbsent
          ? const Value.absent()
          : Value(audioFile),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      urlOrigine: urlOrigine == null && nullToAbsent
          ? const Value.absent()
          : Value(urlOrigine),
      sourceKey: sourceKey == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceKey),
      pdfSha256: pdfSha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfSha256),
      audioSha256: audioSha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(audioSha256),
      sourceModifiedAt: sourceModifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceModifiedAt),
      pdfSizeBytes: pdfSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfSizeBytes),
      audioSizeBytes: audioSizeBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(audioSizeBytes),
      audioDurationSeconds: audioDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(audioDurationSeconds),
      audioPositionSeconds: Value(audioPositionSeconds),
      isFavorite: Value(isFavorite),
      readingProgress: Value(readingProgress),
      lastReadAt: lastReadAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReadAt),
      remoteAvailable: Value(remoteAvailable),
      localUpdatedAt: Value(localUpdatedAt),
    );
  }

  factory LetterRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LetterRow(
      id: serializer.fromJson<String>(json['id']),
      numero: serializer.fromJson<int>(json['numero']),
      slug: serializer.fromJson<String>(json['slug']),
      langue: serializer.fromJson<String>(json['langue']),
      titre: serializer.fromJson<String>(json['titre']),
      contenuHtml: serializer.fromJson<String>(json['contenuHtml']),
      statut: serializer.fromJson<String>(json['statut']),
      pdfFile: serializer.fromJson<String?>(json['pdfFile']),
      pdfUrl: serializer.fromJson<String?>(json['pdfUrl']),
      audioFile: serializer.fromJson<String?>(json['audioFile']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      urlOrigine: serializer.fromJson<String?>(json['urlOrigine']),
      sourceKey: serializer.fromJson<String?>(json['sourceKey']),
      pdfSha256: serializer.fromJson<String?>(json['pdfSha256']),
      audioSha256: serializer.fromJson<String?>(json['audioSha256']),
      sourceModifiedAt: serializer.fromJson<DateTime?>(
        json['sourceModifiedAt'],
      ),
      pdfSizeBytes: serializer.fromJson<int?>(json['pdfSizeBytes']),
      audioSizeBytes: serializer.fromJson<int?>(json['audioSizeBytes']),
      audioDurationSeconds: serializer.fromJson<double?>(
        json['audioDurationSeconds'],
      ),
      audioPositionSeconds: serializer.fromJson<double>(
        json['audioPositionSeconds'],
      ),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      readingProgress: serializer.fromJson<double>(json['readingProgress']),
      lastReadAt: serializer.fromJson<DateTime?>(json['lastReadAt']),
      remoteAvailable: serializer.fromJson<bool>(json['remoteAvailable']),
      localUpdatedAt: serializer.fromJson<DateTime>(json['localUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'numero': serializer.toJson<int>(numero),
      'slug': serializer.toJson<String>(slug),
      'langue': serializer.toJson<String>(langue),
      'titre': serializer.toJson<String>(titre),
      'contenuHtml': serializer.toJson<String>(contenuHtml),
      'statut': serializer.toJson<String>(statut),
      'pdfFile': serializer.toJson<String?>(pdfFile),
      'pdfUrl': serializer.toJson<String?>(pdfUrl),
      'audioFile': serializer.toJson<String?>(audioFile),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'urlOrigine': serializer.toJson<String?>(urlOrigine),
      'sourceKey': serializer.toJson<String?>(sourceKey),
      'pdfSha256': serializer.toJson<String?>(pdfSha256),
      'audioSha256': serializer.toJson<String?>(audioSha256),
      'sourceModifiedAt': serializer.toJson<DateTime?>(sourceModifiedAt),
      'pdfSizeBytes': serializer.toJson<int?>(pdfSizeBytes),
      'audioSizeBytes': serializer.toJson<int?>(audioSizeBytes),
      'audioDurationSeconds': serializer.toJson<double?>(audioDurationSeconds),
      'audioPositionSeconds': serializer.toJson<double>(audioPositionSeconds),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'readingProgress': serializer.toJson<double>(readingProgress),
      'lastReadAt': serializer.toJson<DateTime?>(lastReadAt),
      'remoteAvailable': serializer.toJson<bool>(remoteAvailable),
      'localUpdatedAt': serializer.toJson<DateTime>(localUpdatedAt),
    };
  }

  LetterRow copyWith({
    String? id,
    int? numero,
    String? slug,
    String? langue,
    String? titre,
    String? contenuHtml,
    String? statut,
    Value<String?> pdfFile = const Value.absent(),
    Value<String?> pdfUrl = const Value.absent(),
    Value<String?> audioFile = const Value.absent(),
    Value<String?> audioUrl = const Value.absent(),
    Value<String?> urlOrigine = const Value.absent(),
    Value<String?> sourceKey = const Value.absent(),
    Value<String?> pdfSha256 = const Value.absent(),
    Value<String?> audioSha256 = const Value.absent(),
    Value<DateTime?> sourceModifiedAt = const Value.absent(),
    Value<int?> pdfSizeBytes = const Value.absent(),
    Value<int?> audioSizeBytes = const Value.absent(),
    Value<double?> audioDurationSeconds = const Value.absent(),
    double? audioPositionSeconds,
    bool? isFavorite,
    double? readingProgress,
    Value<DateTime?> lastReadAt = const Value.absent(),
    bool? remoteAvailable,
    DateTime? localUpdatedAt,
  }) => LetterRow(
    id: id ?? this.id,
    numero: numero ?? this.numero,
    slug: slug ?? this.slug,
    langue: langue ?? this.langue,
    titre: titre ?? this.titre,
    contenuHtml: contenuHtml ?? this.contenuHtml,
    statut: statut ?? this.statut,
    pdfFile: pdfFile.present ? pdfFile.value : this.pdfFile,
    pdfUrl: pdfUrl.present ? pdfUrl.value : this.pdfUrl,
    audioFile: audioFile.present ? audioFile.value : this.audioFile,
    audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
    urlOrigine: urlOrigine.present ? urlOrigine.value : this.urlOrigine,
    sourceKey: sourceKey.present ? sourceKey.value : this.sourceKey,
    pdfSha256: pdfSha256.present ? pdfSha256.value : this.pdfSha256,
    audioSha256: audioSha256.present ? audioSha256.value : this.audioSha256,
    sourceModifiedAt: sourceModifiedAt.present
        ? sourceModifiedAt.value
        : this.sourceModifiedAt,
    pdfSizeBytes: pdfSizeBytes.present ? pdfSizeBytes.value : this.pdfSizeBytes,
    audioSizeBytes: audioSizeBytes.present
        ? audioSizeBytes.value
        : this.audioSizeBytes,
    audioDurationSeconds: audioDurationSeconds.present
        ? audioDurationSeconds.value
        : this.audioDurationSeconds,
    audioPositionSeconds: audioPositionSeconds ?? this.audioPositionSeconds,
    isFavorite: isFavorite ?? this.isFavorite,
    readingProgress: readingProgress ?? this.readingProgress,
    lastReadAt: lastReadAt.present ? lastReadAt.value : this.lastReadAt,
    remoteAvailable: remoteAvailable ?? this.remoteAvailable,
    localUpdatedAt: localUpdatedAt ?? this.localUpdatedAt,
  );
  LetterRow copyWithCompanion(LettersCompanion data) {
    return LetterRow(
      id: data.id.present ? data.id.value : this.id,
      numero: data.numero.present ? data.numero.value : this.numero,
      slug: data.slug.present ? data.slug.value : this.slug,
      langue: data.langue.present ? data.langue.value : this.langue,
      titre: data.titre.present ? data.titre.value : this.titre,
      contenuHtml: data.contenuHtml.present
          ? data.contenuHtml.value
          : this.contenuHtml,
      statut: data.statut.present ? data.statut.value : this.statut,
      pdfFile: data.pdfFile.present ? data.pdfFile.value : this.pdfFile,
      pdfUrl: data.pdfUrl.present ? data.pdfUrl.value : this.pdfUrl,
      audioFile: data.audioFile.present ? data.audioFile.value : this.audioFile,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      urlOrigine: data.urlOrigine.present
          ? data.urlOrigine.value
          : this.urlOrigine,
      sourceKey: data.sourceKey.present ? data.sourceKey.value : this.sourceKey,
      pdfSha256: data.pdfSha256.present ? data.pdfSha256.value : this.pdfSha256,
      audioSha256: data.audioSha256.present
          ? data.audioSha256.value
          : this.audioSha256,
      sourceModifiedAt: data.sourceModifiedAt.present
          ? data.sourceModifiedAt.value
          : this.sourceModifiedAt,
      pdfSizeBytes: data.pdfSizeBytes.present
          ? data.pdfSizeBytes.value
          : this.pdfSizeBytes,
      audioSizeBytes: data.audioSizeBytes.present
          ? data.audioSizeBytes.value
          : this.audioSizeBytes,
      audioDurationSeconds: data.audioDurationSeconds.present
          ? data.audioDurationSeconds.value
          : this.audioDurationSeconds,
      audioPositionSeconds: data.audioPositionSeconds.present
          ? data.audioPositionSeconds.value
          : this.audioPositionSeconds,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      readingProgress: data.readingProgress.present
          ? data.readingProgress.value
          : this.readingProgress,
      lastReadAt: data.lastReadAt.present
          ? data.lastReadAt.value
          : this.lastReadAt,
      remoteAvailable: data.remoteAvailable.present
          ? data.remoteAvailable.value
          : this.remoteAvailable,
      localUpdatedAt: data.localUpdatedAt.present
          ? data.localUpdatedAt.value
          : this.localUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LetterRow(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('slug: $slug, ')
          ..write('langue: $langue, ')
          ..write('titre: $titre, ')
          ..write('contenuHtml: $contenuHtml, ')
          ..write('statut: $statut, ')
          ..write('pdfFile: $pdfFile, ')
          ..write('pdfUrl: $pdfUrl, ')
          ..write('audioFile: $audioFile, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('urlOrigine: $urlOrigine, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('pdfSha256: $pdfSha256, ')
          ..write('audioSha256: $audioSha256, ')
          ..write('sourceModifiedAt: $sourceModifiedAt, ')
          ..write('pdfSizeBytes: $pdfSizeBytes, ')
          ..write('audioSizeBytes: $audioSizeBytes, ')
          ..write('audioDurationSeconds: $audioDurationSeconds, ')
          ..write('audioPositionSeconds: $audioPositionSeconds, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('readingProgress: $readingProgress, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('remoteAvailable: $remoteAvailable, ')
          ..write('localUpdatedAt: $localUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    numero,
    slug,
    langue,
    titre,
    contenuHtml,
    statut,
    pdfFile,
    pdfUrl,
    audioFile,
    audioUrl,
    urlOrigine,
    sourceKey,
    pdfSha256,
    audioSha256,
    sourceModifiedAt,
    pdfSizeBytes,
    audioSizeBytes,
    audioDurationSeconds,
    audioPositionSeconds,
    isFavorite,
    readingProgress,
    lastReadAt,
    remoteAvailable,
    localUpdatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LetterRow &&
          other.id == this.id &&
          other.numero == this.numero &&
          other.slug == this.slug &&
          other.langue == this.langue &&
          other.titre == this.titre &&
          other.contenuHtml == this.contenuHtml &&
          other.statut == this.statut &&
          other.pdfFile == this.pdfFile &&
          other.pdfUrl == this.pdfUrl &&
          other.audioFile == this.audioFile &&
          other.audioUrl == this.audioUrl &&
          other.urlOrigine == this.urlOrigine &&
          other.sourceKey == this.sourceKey &&
          other.pdfSha256 == this.pdfSha256 &&
          other.audioSha256 == this.audioSha256 &&
          other.sourceModifiedAt == this.sourceModifiedAt &&
          other.pdfSizeBytes == this.pdfSizeBytes &&
          other.audioSizeBytes == this.audioSizeBytes &&
          other.audioDurationSeconds == this.audioDurationSeconds &&
          other.audioPositionSeconds == this.audioPositionSeconds &&
          other.isFavorite == this.isFavorite &&
          other.readingProgress == this.readingProgress &&
          other.lastReadAt == this.lastReadAt &&
          other.remoteAvailable == this.remoteAvailable &&
          other.localUpdatedAt == this.localUpdatedAt);
}

class LettersCompanion extends UpdateCompanion<LetterRow> {
  final Value<String> id;
  final Value<int> numero;
  final Value<String> slug;
  final Value<String> langue;
  final Value<String> titre;
  final Value<String> contenuHtml;
  final Value<String> statut;
  final Value<String?> pdfFile;
  final Value<String?> pdfUrl;
  final Value<String?> audioFile;
  final Value<String?> audioUrl;
  final Value<String?> urlOrigine;
  final Value<String?> sourceKey;
  final Value<String?> pdfSha256;
  final Value<String?> audioSha256;
  final Value<DateTime?> sourceModifiedAt;
  final Value<int?> pdfSizeBytes;
  final Value<int?> audioSizeBytes;
  final Value<double?> audioDurationSeconds;
  final Value<double> audioPositionSeconds;
  final Value<bool> isFavorite;
  final Value<double> readingProgress;
  final Value<DateTime?> lastReadAt;
  final Value<bool> remoteAvailable;
  final Value<DateTime> localUpdatedAt;
  final Value<int> rowid;
  const LettersCompanion({
    this.id = const Value.absent(),
    this.numero = const Value.absent(),
    this.slug = const Value.absent(),
    this.langue = const Value.absent(),
    this.titre = const Value.absent(),
    this.contenuHtml = const Value.absent(),
    this.statut = const Value.absent(),
    this.pdfFile = const Value.absent(),
    this.pdfUrl = const Value.absent(),
    this.audioFile = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.urlOrigine = const Value.absent(),
    this.sourceKey = const Value.absent(),
    this.pdfSha256 = const Value.absent(),
    this.audioSha256 = const Value.absent(),
    this.sourceModifiedAt = const Value.absent(),
    this.pdfSizeBytes = const Value.absent(),
    this.audioSizeBytes = const Value.absent(),
    this.audioDurationSeconds = const Value.absent(),
    this.audioPositionSeconds = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.readingProgress = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.remoteAvailable = const Value.absent(),
    this.localUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LettersCompanion.insert({
    required String id,
    required int numero,
    required String slug,
    this.langue = const Value.absent(),
    required String titre,
    this.contenuHtml = const Value.absent(),
    this.statut = const Value.absent(),
    this.pdfFile = const Value.absent(),
    this.pdfUrl = const Value.absent(),
    this.audioFile = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.urlOrigine = const Value.absent(),
    this.sourceKey = const Value.absent(),
    this.pdfSha256 = const Value.absent(),
    this.audioSha256 = const Value.absent(),
    this.sourceModifiedAt = const Value.absent(),
    this.pdfSizeBytes = const Value.absent(),
    this.audioSizeBytes = const Value.absent(),
    this.audioDurationSeconds = const Value.absent(),
    this.audioPositionSeconds = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.readingProgress = const Value.absent(),
    this.lastReadAt = const Value.absent(),
    this.remoteAvailable = const Value.absent(),
    this.localUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       numero = Value(numero),
       slug = Value(slug),
       titre = Value(titre);
  static Insertable<LetterRow> custom({
    Expression<String>? id,
    Expression<int>? numero,
    Expression<String>? slug,
    Expression<String>? langue,
    Expression<String>? titre,
    Expression<String>? contenuHtml,
    Expression<String>? statut,
    Expression<String>? pdfFile,
    Expression<String>? pdfUrl,
    Expression<String>? audioFile,
    Expression<String>? audioUrl,
    Expression<String>? urlOrigine,
    Expression<String>? sourceKey,
    Expression<String>? pdfSha256,
    Expression<String>? audioSha256,
    Expression<DateTime>? sourceModifiedAt,
    Expression<int>? pdfSizeBytes,
    Expression<int>? audioSizeBytes,
    Expression<double>? audioDurationSeconds,
    Expression<double>? audioPositionSeconds,
    Expression<bool>? isFavorite,
    Expression<double>? readingProgress,
    Expression<DateTime>? lastReadAt,
    Expression<bool>? remoteAvailable,
    Expression<DateTime>? localUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numero != null) 'numero': numero,
      if (slug != null) 'slug': slug,
      if (langue != null) 'langue': langue,
      if (titre != null) 'titre': titre,
      if (contenuHtml != null) 'contenu_html': contenuHtml,
      if (statut != null) 'statut': statut,
      if (pdfFile != null) 'pdf_file': pdfFile,
      if (pdfUrl != null) 'pdf_url': pdfUrl,
      if (audioFile != null) 'audio_file': audioFile,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (urlOrigine != null) 'url_origine': urlOrigine,
      if (sourceKey != null) 'source_key': sourceKey,
      if (pdfSha256 != null) 'pdf_sha256': pdfSha256,
      if (audioSha256 != null) 'audio_sha256': audioSha256,
      if (sourceModifiedAt != null) 'source_modified_at': sourceModifiedAt,
      if (pdfSizeBytes != null) 'pdf_size_bytes': pdfSizeBytes,
      if (audioSizeBytes != null) 'audio_size_bytes': audioSizeBytes,
      if (audioDurationSeconds != null)
        'audio_duration_seconds': audioDurationSeconds,
      if (audioPositionSeconds != null)
        'audio_position_seconds': audioPositionSeconds,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (readingProgress != null) 'reading_progress': readingProgress,
      if (lastReadAt != null) 'last_read_at': lastReadAt,
      if (remoteAvailable != null) 'remote_available': remoteAvailable,
      if (localUpdatedAt != null) 'local_updated_at': localUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LettersCompanion copyWith({
    Value<String>? id,
    Value<int>? numero,
    Value<String>? slug,
    Value<String>? langue,
    Value<String>? titre,
    Value<String>? contenuHtml,
    Value<String>? statut,
    Value<String?>? pdfFile,
    Value<String?>? pdfUrl,
    Value<String?>? audioFile,
    Value<String?>? audioUrl,
    Value<String?>? urlOrigine,
    Value<String?>? sourceKey,
    Value<String?>? pdfSha256,
    Value<String?>? audioSha256,
    Value<DateTime?>? sourceModifiedAt,
    Value<int?>? pdfSizeBytes,
    Value<int?>? audioSizeBytes,
    Value<double?>? audioDurationSeconds,
    Value<double>? audioPositionSeconds,
    Value<bool>? isFavorite,
    Value<double>? readingProgress,
    Value<DateTime?>? lastReadAt,
    Value<bool>? remoteAvailable,
    Value<DateTime>? localUpdatedAt,
    Value<int>? rowid,
  }) {
    return LettersCompanion(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      slug: slug ?? this.slug,
      langue: langue ?? this.langue,
      titre: titre ?? this.titre,
      contenuHtml: contenuHtml ?? this.contenuHtml,
      statut: statut ?? this.statut,
      pdfFile: pdfFile ?? this.pdfFile,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      audioFile: audioFile ?? this.audioFile,
      audioUrl: audioUrl ?? this.audioUrl,
      urlOrigine: urlOrigine ?? this.urlOrigine,
      sourceKey: sourceKey ?? this.sourceKey,
      pdfSha256: pdfSha256 ?? this.pdfSha256,
      audioSha256: audioSha256 ?? this.audioSha256,
      sourceModifiedAt: sourceModifiedAt ?? this.sourceModifiedAt,
      pdfSizeBytes: pdfSizeBytes ?? this.pdfSizeBytes,
      audioSizeBytes: audioSizeBytes ?? this.audioSizeBytes,
      audioDurationSeconds: audioDurationSeconds ?? this.audioDurationSeconds,
      audioPositionSeconds: audioPositionSeconds ?? this.audioPositionSeconds,
      isFavorite: isFavorite ?? this.isFavorite,
      readingProgress: readingProgress ?? this.readingProgress,
      lastReadAt: lastReadAt ?? this.lastReadAt,
      remoteAvailable: remoteAvailable ?? this.remoteAvailable,
      localUpdatedAt: localUpdatedAt ?? this.localUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (numero.present) {
      map['numero'] = Variable<int>(numero.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (langue.present) {
      map['langue'] = Variable<String>(langue.value);
    }
    if (titre.present) {
      map['titre'] = Variable<String>(titre.value);
    }
    if (contenuHtml.present) {
      map['contenu_html'] = Variable<String>(contenuHtml.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (pdfFile.present) {
      map['pdf_file'] = Variable<String>(pdfFile.value);
    }
    if (pdfUrl.present) {
      map['pdf_url'] = Variable<String>(pdfUrl.value);
    }
    if (audioFile.present) {
      map['audio_file'] = Variable<String>(audioFile.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (urlOrigine.present) {
      map['url_origine'] = Variable<String>(urlOrigine.value);
    }
    if (sourceKey.present) {
      map['source_key'] = Variable<String>(sourceKey.value);
    }
    if (pdfSha256.present) {
      map['pdf_sha256'] = Variable<String>(pdfSha256.value);
    }
    if (audioSha256.present) {
      map['audio_sha256'] = Variable<String>(audioSha256.value);
    }
    if (sourceModifiedAt.present) {
      map['source_modified_at'] = Variable<DateTime>(sourceModifiedAt.value);
    }
    if (pdfSizeBytes.present) {
      map['pdf_size_bytes'] = Variable<int>(pdfSizeBytes.value);
    }
    if (audioSizeBytes.present) {
      map['audio_size_bytes'] = Variable<int>(audioSizeBytes.value);
    }
    if (audioDurationSeconds.present) {
      map['audio_duration_seconds'] = Variable<double>(
        audioDurationSeconds.value,
      );
    }
    if (audioPositionSeconds.present) {
      map['audio_position_seconds'] = Variable<double>(
        audioPositionSeconds.value,
      );
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (readingProgress.present) {
      map['reading_progress'] = Variable<double>(readingProgress.value);
    }
    if (lastReadAt.present) {
      map['last_read_at'] = Variable<DateTime>(lastReadAt.value);
    }
    if (remoteAvailable.present) {
      map['remote_available'] = Variable<bool>(remoteAvailable.value);
    }
    if (localUpdatedAt.present) {
      map['local_updated_at'] = Variable<DateTime>(localUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LettersCompanion(')
          ..write('id: $id, ')
          ..write('numero: $numero, ')
          ..write('slug: $slug, ')
          ..write('langue: $langue, ')
          ..write('titre: $titre, ')
          ..write('contenuHtml: $contenuHtml, ')
          ..write('statut: $statut, ')
          ..write('pdfFile: $pdfFile, ')
          ..write('pdfUrl: $pdfUrl, ')
          ..write('audioFile: $audioFile, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('urlOrigine: $urlOrigine, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('pdfSha256: $pdfSha256, ')
          ..write('audioSha256: $audioSha256, ')
          ..write('sourceModifiedAt: $sourceModifiedAt, ')
          ..write('pdfSizeBytes: $pdfSizeBytes, ')
          ..write('audioSizeBytes: $audioSizeBytes, ')
          ..write('audioDurationSeconds: $audioDurationSeconds, ')
          ..write('audioPositionSeconds: $audioPositionSeconds, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('readingProgress: $readingProgress, ')
          ..write('lastReadAt: $lastReadAt, ')
          ..write('remoteAvailable: $remoteAvailable, ')
          ..write('localUpdatedAt: $localUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyWordsTable extends DailyWords
    with TableInfo<$DailyWordsTable, DailyWordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyWordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateLocaleMeta = const VerificationMeta(
    'dateLocale',
  );
  @override
  late final GeneratedColumn<String> dateLocale = GeneratedColumn<String>(
    'date_locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _langueMeta = const VerificationMeta('langue');
  @override
  late final GeneratedColumn<String> langue = GeneratedColumn<String>(
    'langue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('rw'),
  );
  static const VerificationMeta _titreMeta = const VerificationMeta('titre');
  @override
  late final GeneratedColumn<String> titre = GeneratedColumn<String>(
    'titre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _citationMeta = const VerificationMeta(
    'citation',
  );
  @override
  late final GeneratedColumn<String> citation = GeneratedColumn<String>(
    'citation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceSourceMeta = const VerificationMeta(
    'referenceSource',
  );
  @override
  late final GeneratedColumn<String> referenceSource = GeneratedColumn<String>(
    'reference_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lettreLieeIdMeta = const VerificationMeta(
    'lettreLieeId',
  );
  @override
  late final GeneratedColumn<String> lettreLieeId = GeneratedColumn<String>(
    'lettre_liee_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _audioExtraitUrlMeta = const VerificationMeta(
    'audioExtraitUrl',
  );
  @override
  late final GeneratedColumn<String> audioExtraitUrl = GeneratedColumn<String>(
    'audio_extrait_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceKeyMeta = const VerificationMeta(
    'sourceKey',
  );
  @override
  late final GeneratedColumn<String> sourceKey = GeneratedColumn<String>(
    'source_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('publie'),
  );
  static const VerificationMeta _remoteAvailableMeta = const VerificationMeta(
    'remoteAvailable',
  );
  @override
  late final GeneratedColumn<bool> remoteAvailable = GeneratedColumn<bool>(
    'remote_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remote_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dateLocale,
    langue,
    titre,
    citation,
    referenceSource,
    lettreLieeId,
    audioExtraitUrl,
    sourceKey,
    statut,
    remoteAvailable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_words';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyWordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date_locale')) {
      context.handle(
        _dateLocaleMeta,
        dateLocale.isAcceptableOrUnknown(data['date_locale']!, _dateLocaleMeta),
      );
    } else if (isInserting) {
      context.missing(_dateLocaleMeta);
    }
    if (data.containsKey('langue')) {
      context.handle(
        _langueMeta,
        langue.isAcceptableOrUnknown(data['langue']!, _langueMeta),
      );
    }
    if (data.containsKey('titre')) {
      context.handle(
        _titreMeta,
        titre.isAcceptableOrUnknown(data['titre']!, _titreMeta),
      );
    } else if (isInserting) {
      context.missing(_titreMeta);
    }
    if (data.containsKey('citation')) {
      context.handle(
        _citationMeta,
        citation.isAcceptableOrUnknown(data['citation']!, _citationMeta),
      );
    } else if (isInserting) {
      context.missing(_citationMeta);
    }
    if (data.containsKey('reference_source')) {
      context.handle(
        _referenceSourceMeta,
        referenceSource.isAcceptableOrUnknown(
          data['reference_source']!,
          _referenceSourceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceSourceMeta);
    }
    if (data.containsKey('lettre_liee_id')) {
      context.handle(
        _lettreLieeIdMeta,
        lettreLieeId.isAcceptableOrUnknown(
          data['lettre_liee_id']!,
          _lettreLieeIdMeta,
        ),
      );
    }
    if (data.containsKey('audio_extrait_url')) {
      context.handle(
        _audioExtraitUrlMeta,
        audioExtraitUrl.isAcceptableOrUnknown(
          data['audio_extrait_url']!,
          _audioExtraitUrlMeta,
        ),
      );
    }
    if (data.containsKey('source_key')) {
      context.handle(
        _sourceKeyMeta,
        sourceKey.isAcceptableOrUnknown(data['source_key']!, _sourceKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceKeyMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('remote_available')) {
      context.handle(
        _remoteAvailableMeta,
        remoteAvailable.isAcceptableOrUnknown(
          data['remote_available']!,
          _remoteAvailableMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyWordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyWordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dateLocale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_locale'],
      )!,
      langue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}langue'],
      )!,
      titre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titre'],
      )!,
      citation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}citation'],
      )!,
      referenceSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_source'],
      )!,
      lettreLieeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lettre_liee_id'],
      ),
      audioExtraitUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_extrait_url'],
      ),
      sourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_key'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      remoteAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remote_available'],
      )!,
    );
  }

  @override
  $DailyWordsTable createAlias(String alias) {
    return $DailyWordsTable(attachedDatabase, alias);
  }
}

class DailyWordRow extends DataClass implements Insertable<DailyWordRow> {
  final String id;
  final String dateLocale;
  final String langue;
  final String titre;
  final String citation;
  final String referenceSource;
  final String? lettreLieeId;
  final String? audioExtraitUrl;
  final String sourceKey;
  final String statut;
  final bool remoteAvailable;
  const DailyWordRow({
    required this.id,
    required this.dateLocale,
    required this.langue,
    required this.titre,
    required this.citation,
    required this.referenceSource,
    this.lettreLieeId,
    this.audioExtraitUrl,
    required this.sourceKey,
    required this.statut,
    required this.remoteAvailable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date_locale'] = Variable<String>(dateLocale);
    map['langue'] = Variable<String>(langue);
    map['titre'] = Variable<String>(titre);
    map['citation'] = Variable<String>(citation);
    map['reference_source'] = Variable<String>(referenceSource);
    if (!nullToAbsent || lettreLieeId != null) {
      map['lettre_liee_id'] = Variable<String>(lettreLieeId);
    }
    if (!nullToAbsent || audioExtraitUrl != null) {
      map['audio_extrait_url'] = Variable<String>(audioExtraitUrl);
    }
    map['source_key'] = Variable<String>(sourceKey);
    map['statut'] = Variable<String>(statut);
    map['remote_available'] = Variable<bool>(remoteAvailable);
    return map;
  }

  DailyWordsCompanion toCompanion(bool nullToAbsent) {
    return DailyWordsCompanion(
      id: Value(id),
      dateLocale: Value(dateLocale),
      langue: Value(langue),
      titre: Value(titre),
      citation: Value(citation),
      referenceSource: Value(referenceSource),
      lettreLieeId: lettreLieeId == null && nullToAbsent
          ? const Value.absent()
          : Value(lettreLieeId),
      audioExtraitUrl: audioExtraitUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioExtraitUrl),
      sourceKey: Value(sourceKey),
      statut: Value(statut),
      remoteAvailable: Value(remoteAvailable),
    );
  }

  factory DailyWordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyWordRow(
      id: serializer.fromJson<String>(json['id']),
      dateLocale: serializer.fromJson<String>(json['dateLocale']),
      langue: serializer.fromJson<String>(json['langue']),
      titre: serializer.fromJson<String>(json['titre']),
      citation: serializer.fromJson<String>(json['citation']),
      referenceSource: serializer.fromJson<String>(json['referenceSource']),
      lettreLieeId: serializer.fromJson<String?>(json['lettreLieeId']),
      audioExtraitUrl: serializer.fromJson<String?>(json['audioExtraitUrl']),
      sourceKey: serializer.fromJson<String>(json['sourceKey']),
      statut: serializer.fromJson<String>(json['statut']),
      remoteAvailable: serializer.fromJson<bool>(json['remoteAvailable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dateLocale': serializer.toJson<String>(dateLocale),
      'langue': serializer.toJson<String>(langue),
      'titre': serializer.toJson<String>(titre),
      'citation': serializer.toJson<String>(citation),
      'referenceSource': serializer.toJson<String>(referenceSource),
      'lettreLieeId': serializer.toJson<String?>(lettreLieeId),
      'audioExtraitUrl': serializer.toJson<String?>(audioExtraitUrl),
      'sourceKey': serializer.toJson<String>(sourceKey),
      'statut': serializer.toJson<String>(statut),
      'remoteAvailable': serializer.toJson<bool>(remoteAvailable),
    };
  }

  DailyWordRow copyWith({
    String? id,
    String? dateLocale,
    String? langue,
    String? titre,
    String? citation,
    String? referenceSource,
    Value<String?> lettreLieeId = const Value.absent(),
    Value<String?> audioExtraitUrl = const Value.absent(),
    String? sourceKey,
    String? statut,
    bool? remoteAvailable,
  }) => DailyWordRow(
    id: id ?? this.id,
    dateLocale: dateLocale ?? this.dateLocale,
    langue: langue ?? this.langue,
    titre: titre ?? this.titre,
    citation: citation ?? this.citation,
    referenceSource: referenceSource ?? this.referenceSource,
    lettreLieeId: lettreLieeId.present ? lettreLieeId.value : this.lettreLieeId,
    audioExtraitUrl: audioExtraitUrl.present
        ? audioExtraitUrl.value
        : this.audioExtraitUrl,
    sourceKey: sourceKey ?? this.sourceKey,
    statut: statut ?? this.statut,
    remoteAvailable: remoteAvailable ?? this.remoteAvailable,
  );
  DailyWordRow copyWithCompanion(DailyWordsCompanion data) {
    return DailyWordRow(
      id: data.id.present ? data.id.value : this.id,
      dateLocale: data.dateLocale.present
          ? data.dateLocale.value
          : this.dateLocale,
      langue: data.langue.present ? data.langue.value : this.langue,
      titre: data.titre.present ? data.titre.value : this.titre,
      citation: data.citation.present ? data.citation.value : this.citation,
      referenceSource: data.referenceSource.present
          ? data.referenceSource.value
          : this.referenceSource,
      lettreLieeId: data.lettreLieeId.present
          ? data.lettreLieeId.value
          : this.lettreLieeId,
      audioExtraitUrl: data.audioExtraitUrl.present
          ? data.audioExtraitUrl.value
          : this.audioExtraitUrl,
      sourceKey: data.sourceKey.present ? data.sourceKey.value : this.sourceKey,
      statut: data.statut.present ? data.statut.value : this.statut,
      remoteAvailable: data.remoteAvailable.present
          ? data.remoteAvailable.value
          : this.remoteAvailable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyWordRow(')
          ..write('id: $id, ')
          ..write('dateLocale: $dateLocale, ')
          ..write('langue: $langue, ')
          ..write('titre: $titre, ')
          ..write('citation: $citation, ')
          ..write('referenceSource: $referenceSource, ')
          ..write('lettreLieeId: $lettreLieeId, ')
          ..write('audioExtraitUrl: $audioExtraitUrl, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('statut: $statut, ')
          ..write('remoteAvailable: $remoteAvailable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dateLocale,
    langue,
    titre,
    citation,
    referenceSource,
    lettreLieeId,
    audioExtraitUrl,
    sourceKey,
    statut,
    remoteAvailable,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyWordRow &&
          other.id == this.id &&
          other.dateLocale == this.dateLocale &&
          other.langue == this.langue &&
          other.titre == this.titre &&
          other.citation == this.citation &&
          other.referenceSource == this.referenceSource &&
          other.lettreLieeId == this.lettreLieeId &&
          other.audioExtraitUrl == this.audioExtraitUrl &&
          other.sourceKey == this.sourceKey &&
          other.statut == this.statut &&
          other.remoteAvailable == this.remoteAvailable);
}

class DailyWordsCompanion extends UpdateCompanion<DailyWordRow> {
  final Value<String> id;
  final Value<String> dateLocale;
  final Value<String> langue;
  final Value<String> titre;
  final Value<String> citation;
  final Value<String> referenceSource;
  final Value<String?> lettreLieeId;
  final Value<String?> audioExtraitUrl;
  final Value<String> sourceKey;
  final Value<String> statut;
  final Value<bool> remoteAvailable;
  final Value<int> rowid;
  const DailyWordsCompanion({
    this.id = const Value.absent(),
    this.dateLocale = const Value.absent(),
    this.langue = const Value.absent(),
    this.titre = const Value.absent(),
    this.citation = const Value.absent(),
    this.referenceSource = const Value.absent(),
    this.lettreLieeId = const Value.absent(),
    this.audioExtraitUrl = const Value.absent(),
    this.sourceKey = const Value.absent(),
    this.statut = const Value.absent(),
    this.remoteAvailable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyWordsCompanion.insert({
    required String id,
    required String dateLocale,
    this.langue = const Value.absent(),
    required String titre,
    required String citation,
    required String referenceSource,
    this.lettreLieeId = const Value.absent(),
    this.audioExtraitUrl = const Value.absent(),
    required String sourceKey,
    this.statut = const Value.absent(),
    this.remoteAvailable = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dateLocale = Value(dateLocale),
       titre = Value(titre),
       citation = Value(citation),
       referenceSource = Value(referenceSource),
       sourceKey = Value(sourceKey);
  static Insertable<DailyWordRow> custom({
    Expression<String>? id,
    Expression<String>? dateLocale,
    Expression<String>? langue,
    Expression<String>? titre,
    Expression<String>? citation,
    Expression<String>? referenceSource,
    Expression<String>? lettreLieeId,
    Expression<String>? audioExtraitUrl,
    Expression<String>? sourceKey,
    Expression<String>? statut,
    Expression<bool>? remoteAvailable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateLocale != null) 'date_locale': dateLocale,
      if (langue != null) 'langue': langue,
      if (titre != null) 'titre': titre,
      if (citation != null) 'citation': citation,
      if (referenceSource != null) 'reference_source': referenceSource,
      if (lettreLieeId != null) 'lettre_liee_id': lettreLieeId,
      if (audioExtraitUrl != null) 'audio_extrait_url': audioExtraitUrl,
      if (sourceKey != null) 'source_key': sourceKey,
      if (statut != null) 'statut': statut,
      if (remoteAvailable != null) 'remote_available': remoteAvailable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyWordsCompanion copyWith({
    Value<String>? id,
    Value<String>? dateLocale,
    Value<String>? langue,
    Value<String>? titre,
    Value<String>? citation,
    Value<String>? referenceSource,
    Value<String?>? lettreLieeId,
    Value<String?>? audioExtraitUrl,
    Value<String>? sourceKey,
    Value<String>? statut,
    Value<bool>? remoteAvailable,
    Value<int>? rowid,
  }) {
    return DailyWordsCompanion(
      id: id ?? this.id,
      dateLocale: dateLocale ?? this.dateLocale,
      langue: langue ?? this.langue,
      titre: titre ?? this.titre,
      citation: citation ?? this.citation,
      referenceSource: referenceSource ?? this.referenceSource,
      lettreLieeId: lettreLieeId ?? this.lettreLieeId,
      audioExtraitUrl: audioExtraitUrl ?? this.audioExtraitUrl,
      sourceKey: sourceKey ?? this.sourceKey,
      statut: statut ?? this.statut,
      remoteAvailable: remoteAvailable ?? this.remoteAvailable,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dateLocale.present) {
      map['date_locale'] = Variable<String>(dateLocale.value);
    }
    if (langue.present) {
      map['langue'] = Variable<String>(langue.value);
    }
    if (titre.present) {
      map['titre'] = Variable<String>(titre.value);
    }
    if (citation.present) {
      map['citation'] = Variable<String>(citation.value);
    }
    if (referenceSource.present) {
      map['reference_source'] = Variable<String>(referenceSource.value);
    }
    if (lettreLieeId.present) {
      map['lettre_liee_id'] = Variable<String>(lettreLieeId.value);
    }
    if (audioExtraitUrl.present) {
      map['audio_extrait_url'] = Variable<String>(audioExtraitUrl.value);
    }
    if (sourceKey.present) {
      map['source_key'] = Variable<String>(sourceKey.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (remoteAvailable.present) {
      map['remote_available'] = Variable<bool>(remoteAvailable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyWordsCompanion(')
          ..write('id: $id, ')
          ..write('dateLocale: $dateLocale, ')
          ..write('langue: $langue, ')
          ..write('titre: $titre, ')
          ..write('citation: $citation, ')
          ..write('referenceSource: $referenceSource, ')
          ..write('lettreLieeId: $lettreLieeId, ')
          ..write('audioExtraitUrl: $audioExtraitUrl, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('statut: $statut, ')
          ..write('remoteAvailable: $remoteAvailable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DownloadJobsTable extends DownloadJobs
    with TableInfo<$DownloadJobsTable, DownloadJob> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadJobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _letterIdMeta = const VerificationMeta(
    'letterId',
  );
  @override
  late final GeneratedColumn<String> letterId = GeneratedColumn<String>(
    'letter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileTypeMeta = const VerificationMeta(
    'fileType',
  );
  @override
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
    'file_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _bytesReceivedMeta = const VerificationMeta(
    'bytesReceived',
  );
  @override
  late final GeneratedColumn<int> bytesReceived = GeneratedColumn<int>(
    'bytes_received',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalBytesMeta = const VerificationMeta(
    'totalBytes',
  );
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
    'total_bytes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    letterId,
    fileType,
    remoteUrl,
    fileName,
    status,
    bytesReceived,
    totalBytes,
    sha256,
    localPath,
    error,
    attempts,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'download_jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DownloadJob> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('letter_id')) {
      context.handle(
        _letterIdMeta,
        letterId.isAcceptableOrUnknown(data['letter_id']!, _letterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_letterIdMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(
        _fileTypeMeta,
        fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_remoteUrlMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('bytes_received')) {
      context.handle(
        _bytesReceivedMeta,
        bytesReceived.isAcceptableOrUnknown(
          data['bytes_received']!,
          _bytesReceivedMeta,
        ),
      );
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
        _totalBytesMeta,
        totalBytes.isAcceptableOrUnknown(data['total_bytes']!, _totalBytesMeta),
      );
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {letterId, fileType},
  ];
  @override
  DownloadJob map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadJob(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      letterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}letter_id'],
      )!,
      fileType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_type'],
      )!,
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      bytesReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bytes_received'],
      )!,
      totalBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bytes'],
      ),
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      ),
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      ),
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DownloadJobsTable createAlias(String alias) {
    return $DownloadJobsTable(attachedDatabase, alias);
  }
}

class DownloadJob extends DataClass implements Insertable<DownloadJob> {
  final int id;
  final String letterId;
  final String fileType;
  final String remoteUrl;
  final String fileName;
  final String status;
  final int bytesReceived;
  final int? totalBytes;
  final String? sha256;
  final String? localPath;
  final String? error;
  final int attempts;
  final DateTime updatedAt;
  const DownloadJob({
    required this.id,
    required this.letterId,
    required this.fileType,
    required this.remoteUrl,
    required this.fileName,
    required this.status,
    required this.bytesReceived,
    this.totalBytes,
    this.sha256,
    this.localPath,
    this.error,
    required this.attempts,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['letter_id'] = Variable<String>(letterId);
    map['file_type'] = Variable<String>(fileType);
    map['remote_url'] = Variable<String>(remoteUrl);
    map['file_name'] = Variable<String>(fileName);
    map['status'] = Variable<String>(status);
    map['bytes_received'] = Variable<int>(bytesReceived);
    if (!nullToAbsent || totalBytes != null) {
      map['total_bytes'] = Variable<int>(totalBytes);
    }
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    map['attempts'] = Variable<int>(attempts);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DownloadJobsCompanion toCompanion(bool nullToAbsent) {
    return DownloadJobsCompanion(
      id: Value(id),
      letterId: Value(letterId),
      fileType: Value(fileType),
      remoteUrl: Value(remoteUrl),
      fileName: Value(fileName),
      status: Value(status),
      bytesReceived: Value(bytesReceived),
      totalBytes: totalBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalBytes),
      sha256: sha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      error: error == null && nullToAbsent
          ? const Value.absent()
          : Value(error),
      attempts: Value(attempts),
      updatedAt: Value(updatedAt),
    );
  }

  factory DownloadJob.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadJob(
      id: serializer.fromJson<int>(json['id']),
      letterId: serializer.fromJson<String>(json['letterId']),
      fileType: serializer.fromJson<String>(json['fileType']),
      remoteUrl: serializer.fromJson<String>(json['remoteUrl']),
      fileName: serializer.fromJson<String>(json['fileName']),
      status: serializer.fromJson<String>(json['status']),
      bytesReceived: serializer.fromJson<int>(json['bytesReceived']),
      totalBytes: serializer.fromJson<int?>(json['totalBytes']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      error: serializer.fromJson<String?>(json['error']),
      attempts: serializer.fromJson<int>(json['attempts']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'letterId': serializer.toJson<String>(letterId),
      'fileType': serializer.toJson<String>(fileType),
      'remoteUrl': serializer.toJson<String>(remoteUrl),
      'fileName': serializer.toJson<String>(fileName),
      'status': serializer.toJson<String>(status),
      'bytesReceived': serializer.toJson<int>(bytesReceived),
      'totalBytes': serializer.toJson<int?>(totalBytes),
      'sha256': serializer.toJson<String?>(sha256),
      'localPath': serializer.toJson<String?>(localPath),
      'error': serializer.toJson<String?>(error),
      'attempts': serializer.toJson<int>(attempts),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DownloadJob copyWith({
    int? id,
    String? letterId,
    String? fileType,
    String? remoteUrl,
    String? fileName,
    String? status,
    int? bytesReceived,
    Value<int?> totalBytes = const Value.absent(),
    Value<String?> sha256 = const Value.absent(),
    Value<String?> localPath = const Value.absent(),
    Value<String?> error = const Value.absent(),
    int? attempts,
    DateTime? updatedAt,
  }) => DownloadJob(
    id: id ?? this.id,
    letterId: letterId ?? this.letterId,
    fileType: fileType ?? this.fileType,
    remoteUrl: remoteUrl ?? this.remoteUrl,
    fileName: fileName ?? this.fileName,
    status: status ?? this.status,
    bytesReceived: bytesReceived ?? this.bytesReceived,
    totalBytes: totalBytes.present ? totalBytes.value : this.totalBytes,
    sha256: sha256.present ? sha256.value : this.sha256,
    localPath: localPath.present ? localPath.value : this.localPath,
    error: error.present ? error.value : this.error,
    attempts: attempts ?? this.attempts,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DownloadJob copyWithCompanion(DownloadJobsCompanion data) {
    return DownloadJob(
      id: data.id.present ? data.id.value : this.id,
      letterId: data.letterId.present ? data.letterId.value : this.letterId,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      status: data.status.present ? data.status.value : this.status,
      bytesReceived: data.bytesReceived.present
          ? data.bytesReceived.value
          : this.bytesReceived,
      totalBytes: data.totalBytes.present
          ? data.totalBytes.value
          : this.totalBytes,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      error: data.error.present ? data.error.value : this.error,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadJob(')
          ..write('id: $id, ')
          ..write('letterId: $letterId, ')
          ..write('fileType: $fileType, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('fileName: $fileName, ')
          ..write('status: $status, ')
          ..write('bytesReceived: $bytesReceived, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('sha256: $sha256, ')
          ..write('localPath: $localPath, ')
          ..write('error: $error, ')
          ..write('attempts: $attempts, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    letterId,
    fileType,
    remoteUrl,
    fileName,
    status,
    bytesReceived,
    totalBytes,
    sha256,
    localPath,
    error,
    attempts,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadJob &&
          other.id == this.id &&
          other.letterId == this.letterId &&
          other.fileType == this.fileType &&
          other.remoteUrl == this.remoteUrl &&
          other.fileName == this.fileName &&
          other.status == this.status &&
          other.bytesReceived == this.bytesReceived &&
          other.totalBytes == this.totalBytes &&
          other.sha256 == this.sha256 &&
          other.localPath == this.localPath &&
          other.error == this.error &&
          other.attempts == this.attempts &&
          other.updatedAt == this.updatedAt);
}

class DownloadJobsCompanion extends UpdateCompanion<DownloadJob> {
  final Value<int> id;
  final Value<String> letterId;
  final Value<String> fileType;
  final Value<String> remoteUrl;
  final Value<String> fileName;
  final Value<String> status;
  final Value<int> bytesReceived;
  final Value<int?> totalBytes;
  final Value<String?> sha256;
  final Value<String?> localPath;
  final Value<String?> error;
  final Value<int> attempts;
  final Value<DateTime> updatedAt;
  const DownloadJobsCompanion({
    this.id = const Value.absent(),
    this.letterId = const Value.absent(),
    this.fileType = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.fileName = const Value.absent(),
    this.status = const Value.absent(),
    this.bytesReceived = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.localPath = const Value.absent(),
    this.error = const Value.absent(),
    this.attempts = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DownloadJobsCompanion.insert({
    this.id = const Value.absent(),
    required String letterId,
    required String fileType,
    required String remoteUrl,
    required String fileName,
    this.status = const Value.absent(),
    this.bytesReceived = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.localPath = const Value.absent(),
    this.error = const Value.absent(),
    this.attempts = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : letterId = Value(letterId),
       fileType = Value(fileType),
       remoteUrl = Value(remoteUrl),
       fileName = Value(fileName);
  static Insertable<DownloadJob> custom({
    Expression<int>? id,
    Expression<String>? letterId,
    Expression<String>? fileType,
    Expression<String>? remoteUrl,
    Expression<String>? fileName,
    Expression<String>? status,
    Expression<int>? bytesReceived,
    Expression<int>? totalBytes,
    Expression<String>? sha256,
    Expression<String>? localPath,
    Expression<String>? error,
    Expression<int>? attempts,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (letterId != null) 'letter_id': letterId,
      if (fileType != null) 'file_type': fileType,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (fileName != null) 'file_name': fileName,
      if (status != null) 'status': status,
      if (bytesReceived != null) 'bytes_received': bytesReceived,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (sha256 != null) 'sha256': sha256,
      if (localPath != null) 'local_path': localPath,
      if (error != null) 'error': error,
      if (attempts != null) 'attempts': attempts,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DownloadJobsCompanion copyWith({
    Value<int>? id,
    Value<String>? letterId,
    Value<String>? fileType,
    Value<String>? remoteUrl,
    Value<String>? fileName,
    Value<String>? status,
    Value<int>? bytesReceived,
    Value<int?>? totalBytes,
    Value<String?>? sha256,
    Value<String?>? localPath,
    Value<String?>? error,
    Value<int>? attempts,
    Value<DateTime>? updatedAt,
  }) {
    return DownloadJobsCompanion(
      id: id ?? this.id,
      letterId: letterId ?? this.letterId,
      fileType: fileType ?? this.fileType,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      fileName: fileName ?? this.fileName,
      status: status ?? this.status,
      bytesReceived: bytesReceived ?? this.bytesReceived,
      totalBytes: totalBytes ?? this.totalBytes,
      sha256: sha256 ?? this.sha256,
      localPath: localPath ?? this.localPath,
      error: error ?? this.error,
      attempts: attempts ?? this.attempts,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (letterId.present) {
      map['letter_id'] = Variable<String>(letterId.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (bytesReceived.present) {
      map['bytes_received'] = Variable<int>(bytesReceived.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadJobsCompanion(')
          ..write('id: $id, ')
          ..write('letterId: $letterId, ')
          ..write('fileType: $fileType, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('fileName: $fileName, ')
          ..write('status: $status, ')
          ..write('bytesReceived: $bytesReceived, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('sha256: $sha256, ')
          ..write('localPath: $localPath, ')
          ..write('error: $error, ')
          ..write('attempts: $attempts, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LettersTable letters = $LettersTable(this);
  late final $DailyWordsTable dailyWords = $DailyWordsTable(this);
  late final $DownloadJobsTable downloadJobs = $DownloadJobsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    letters,
    dailyWords,
    downloadJobs,
  ];
}

typedef $$LettersTableCreateCompanionBuilder = LettersCompanion Function({
  required String id,
  required int numero,
  required String slug,
  Value<String> langue,
  required String titre,
  Value<String> contenuHtml,
  Value<String> statut,
  Value<String?> pdfFile,
  Value<String?> pdfUrl,
  Value<String?> audioFile,
  Value<String?> audioUrl,
  Value<String?> urlOrigine,
  Value<String?> sourceKey,
  Value<String?> pdfSha256,
  Value<String?> audioSha256,
  Value<DateTime?> sourceModifiedAt,
  Value<int?> pdfSizeBytes,
  Value<int?> audioSizeBytes,
  Value<double?> audioDurationSeconds,
  Value<double> audioPositionSeconds,
  Value<bool> isFavorite,
  Value<double> readingProgress,
  Value<DateTime?> lastReadAt,
  Value<bool> remoteAvailable,
  Value<DateTime> localUpdatedAt,
  Value<int> rowid,
});
typedef $$LettersTableUpdateCompanionBuilder = LettersCompanion Function({
  Value<String> id,
  Value<int> numero,
  Value<String> slug,
  Value<String> langue,
  Value<String> titre,
  Value<String> contenuHtml,
  Value<String> statut,
  Value<String?> pdfFile,
  Value<String?> pdfUrl,
  Value<String?> audioFile,
  Value<String?> audioUrl,
  Value<String?> urlOrigine,
  Value<String?> sourceKey,
  Value<String?> pdfSha256,
  Value<String?> audioSha256,
  Value<DateTime?> sourceModifiedAt,
  Value<int?> pdfSizeBytes,
  Value<int?> audioSizeBytes,
  Value<double?> audioDurationSeconds,
  Value<double> audioPositionSeconds,
  Value<bool> isFavorite,
  Value<double> readingProgress,
  Value<DateTime?> lastReadAt,
  Value<bool> remoteAvailable,
  Value<DateTime> localUpdatedAt,
  Value<int> rowid,
});

class $$LettersTableFilterComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get langue => $composableBuilder(
    column: $table.langue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titre => $composableBuilder(
    column: $table.titre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contenuHtml => $composableBuilder(
    column: $table.contenuHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfFile => $composableBuilder(
    column: $table.pdfFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfUrl => $composableBuilder(
    column: $table.pdfUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioFile => $composableBuilder(
    column: $table.audioFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urlOrigine => $composableBuilder(
    column: $table.urlOrigine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceKey => $composableBuilder(
    column: $table.sourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfSha256 => $composableBuilder(
    column: $table.pdfSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioSha256 => $composableBuilder(
    column: $table.audioSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sourceModifiedAt => $composableBuilder(
    column: $table.sourceModifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pdfSizeBytes => $composableBuilder(
    column: $table.pdfSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get audioSizeBytes => $composableBuilder(
    column: $table.audioSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get audioDurationSeconds => $composableBuilder(
    column: $table.audioDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get audioPositionSeconds => $composableBuilder(
    column: $table.audioPositionSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get readingProgress => $composableBuilder(
    column: $table.readingProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remoteAvailable => $composableBuilder(
    column: $table.remoteAvailable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localUpdatedAt => $composableBuilder(
    column: $table.localUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LettersTableOrderingComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get langue => $composableBuilder(
    column: $table.langue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titre => $composableBuilder(
    column: $table.titre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contenuHtml => $composableBuilder(
    column: $table.contenuHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfFile => $composableBuilder(
    column: $table.pdfFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfUrl => $composableBuilder(
    column: $table.pdfUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioFile => $composableBuilder(
    column: $table.audioFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urlOrigine => $composableBuilder(
    column: $table.urlOrigine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceKey => $composableBuilder(
    column: $table.sourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfSha256 => $composableBuilder(
    column: $table.pdfSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioSha256 => $composableBuilder(
    column: $table.audioSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sourceModifiedAt => $composableBuilder(
    column: $table.sourceModifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pdfSizeBytes => $composableBuilder(
    column: $table.pdfSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get audioSizeBytes => $composableBuilder(
    column: $table.audioSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get audioDurationSeconds => $composableBuilder(
    column: $table.audioDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get audioPositionSeconds => $composableBuilder(
    column: $table.audioPositionSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get readingProgress => $composableBuilder(
    column: $table.readingProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remoteAvailable => $composableBuilder(
    column: $table.remoteAvailable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localUpdatedAt => $composableBuilder(
    column: $table.localUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LettersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LettersTable> {
  $$LettersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get langue =>
      $composableBuilder(column: $table.langue, builder: (column) => column);

  GeneratedColumn<String> get titre =>
      $composableBuilder(column: $table.titre, builder: (column) => column);

  GeneratedColumn<String> get contenuHtml => $composableBuilder(
    column: $table.contenuHtml,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<String> get pdfFile =>
      $composableBuilder(column: $table.pdfFile, builder: (column) => column);

  GeneratedColumn<String> get pdfUrl =>
      $composableBuilder(column: $table.pdfUrl, builder: (column) => column);

  GeneratedColumn<String> get audioFile =>
      $composableBuilder(column: $table.audioFile, builder: (column) => column);

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<String> get urlOrigine => $composableBuilder(
    column: $table.urlOrigine,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceKey =>
      $composableBuilder(column: $table.sourceKey, builder: (column) => column);

  GeneratedColumn<String> get pdfSha256 =>
      $composableBuilder(column: $table.pdfSha256, builder: (column) => column);

  GeneratedColumn<String> get audioSha256 => $composableBuilder(
    column: $table.audioSha256,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sourceModifiedAt => $composableBuilder(
    column: $table.sourceModifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pdfSizeBytes => $composableBuilder(
    column: $table.pdfSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get audioSizeBytes => $composableBuilder(
    column: $table.audioSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get audioDurationSeconds => $composableBuilder(
    column: $table.audioDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<double> get audioPositionSeconds => $composableBuilder(
    column: $table.audioPositionSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<double> get readingProgress => $composableBuilder(
    column: $table.readingProgress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReadAt => $composableBuilder(
    column: $table.lastReadAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remoteAvailable => $composableBuilder(
    column: $table.remoteAvailable,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get localUpdatedAt => $composableBuilder(
    column: $table.localUpdatedAt,
    builder: (column) => column,
  );
}

class $$LettersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LettersTable,
          LetterRow,
          $$LettersTableFilterComposer,
          $$LettersTableOrderingComposer,
          $$LettersTableAnnotationComposer,
          $$LettersTableCreateCompanionBuilder,
          $$LettersTableUpdateCompanionBuilder,
          (LetterRow, BaseReferences<_$AppDatabase, $LettersTable, LetterRow>),
          LetterRow,
          PrefetchHooks Function()
        > {
  $$LettersTableTableManager(_$AppDatabase db, $LettersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LettersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LettersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LettersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> numero = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> langue = const Value.absent(),
                Value<String> titre = const Value.absent(),
                Value<String> contenuHtml = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<String?> pdfFile = const Value.absent(),
                Value<String?> pdfUrl = const Value.absent(),
                Value<String?> audioFile = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<String?> urlOrigine = const Value.absent(),
                Value<String?> sourceKey = const Value.absent(),
                Value<String?> pdfSha256 = const Value.absent(),
                Value<String?> audioSha256 = const Value.absent(),
                Value<DateTime?> sourceModifiedAt = const Value.absent(),
                Value<int?> pdfSizeBytes = const Value.absent(),
                Value<int?> audioSizeBytes = const Value.absent(),
                Value<double?> audioDurationSeconds = const Value.absent(),
                Value<double> audioPositionSeconds = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<double> readingProgress = const Value.absent(),
                Value<DateTime?> lastReadAt = const Value.absent(),
                Value<bool> remoteAvailable = const Value.absent(),
                Value<DateTime> localUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LettersCompanion(
                id: id,
                numero: numero,
                slug: slug,
                langue: langue,
                titre: titre,
                contenuHtml: contenuHtml,
                statut: statut,
                pdfFile: pdfFile,
                pdfUrl: pdfUrl,
                audioFile: audioFile,
                audioUrl: audioUrl,
                urlOrigine: urlOrigine,
                sourceKey: sourceKey,
                pdfSha256: pdfSha256,
                audioSha256: audioSha256,
                sourceModifiedAt: sourceModifiedAt,
                pdfSizeBytes: pdfSizeBytes,
                audioSizeBytes: audioSizeBytes,
                audioDurationSeconds: audioDurationSeconds,
                audioPositionSeconds: audioPositionSeconds,
                isFavorite: isFavorite,
                readingProgress: readingProgress,
                lastReadAt: lastReadAt,
                remoteAvailable: remoteAvailable,
                localUpdatedAt: localUpdatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int numero,
                required String slug,
                Value<String> langue = const Value.absent(),
                required String titre,
                Value<String> contenuHtml = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<String?> pdfFile = const Value.absent(),
                Value<String?> pdfUrl = const Value.absent(),
                Value<String?> audioFile = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<String?> urlOrigine = const Value.absent(),
                Value<String?> sourceKey = const Value.absent(),
                Value<String?> pdfSha256 = const Value.absent(),
                Value<String?> audioSha256 = const Value.absent(),
                Value<DateTime?> sourceModifiedAt = const Value.absent(),
                Value<int?> pdfSizeBytes = const Value.absent(),
                Value<int?> audioSizeBytes = const Value.absent(),
                Value<double?> audioDurationSeconds = const Value.absent(),
                Value<double> audioPositionSeconds = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<double> readingProgress = const Value.absent(),
                Value<DateTime?> lastReadAt = const Value.absent(),
                Value<bool> remoteAvailable = const Value.absent(),
                Value<DateTime> localUpdatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LettersCompanion.insert(
                id: id,
                numero: numero,
                slug: slug,
                langue: langue,
                titre: titre,
                contenuHtml: contenuHtml,
                statut: statut,
                pdfFile: pdfFile,
                pdfUrl: pdfUrl,
                audioFile: audioFile,
                audioUrl: audioUrl,
                urlOrigine: urlOrigine,
                sourceKey: sourceKey,
                pdfSha256: pdfSha256,
                audioSha256: audioSha256,
                sourceModifiedAt: sourceModifiedAt,
                pdfSizeBytes: pdfSizeBytes,
                audioSizeBytes: audioSizeBytes,
                audioDurationSeconds: audioDurationSeconds,
                audioPositionSeconds: audioPositionSeconds,
                isFavorite: isFavorite,
                readingProgress: readingProgress,
                lastReadAt: lastReadAt,
                remoteAvailable: remoteAvailable,
                localUpdatedAt: localUpdatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LettersTable, LetterRow>(table),
                  BaseReferences<_$AppDatabase, $LettersTable, LetterRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LettersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LettersTable,
      LetterRow,
      $$LettersTableFilterComposer,
      $$LettersTableOrderingComposer,
      $$LettersTableAnnotationComposer,
      $$LettersTableCreateCompanionBuilder,
      $$LettersTableUpdateCompanionBuilder,
      (LetterRow, BaseReferences<_$AppDatabase, $LettersTable, LetterRow>),
      LetterRow,
      PrefetchHooks Function()
    >;
typedef $$DailyWordsTableCreateCompanionBuilder = DailyWordsCompanion Function({
  required String id,
  required String dateLocale,
  Value<String> langue,
  required String titre,
  required String citation,
  required String referenceSource,
  Value<String?> lettreLieeId,
  Value<String?> audioExtraitUrl,
  required String sourceKey,
  Value<String> statut,
  Value<bool> remoteAvailable,
  Value<int> rowid,
});
typedef $$DailyWordsTableUpdateCompanionBuilder = DailyWordsCompanion Function({
  Value<String> id,
  Value<String> dateLocale,
  Value<String> langue,
  Value<String> titre,
  Value<String> citation,
  Value<String> referenceSource,
  Value<String?> lettreLieeId,
  Value<String?> audioExtraitUrl,
  Value<String> sourceKey,
  Value<String> statut,
  Value<bool> remoteAvailable,
  Value<int> rowid,
});

class $$DailyWordsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyWordsTable> {
  $$DailyWordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateLocale => $composableBuilder(
    column: $table.dateLocale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get langue => $composableBuilder(
    column: $table.langue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titre => $composableBuilder(
    column: $table.titre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get citation => $composableBuilder(
    column: $table.citation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceSource => $composableBuilder(
    column: $table.referenceSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lettreLieeId => $composableBuilder(
    column: $table.lettreLieeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioExtraitUrl => $composableBuilder(
    column: $table.audioExtraitUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceKey => $composableBuilder(
    column: $table.sourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remoteAvailable => $composableBuilder(
    column: $table.remoteAvailable,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyWordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyWordsTable> {
  $$DailyWordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateLocale => $composableBuilder(
    column: $table.dateLocale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get langue => $composableBuilder(
    column: $table.langue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titre => $composableBuilder(
    column: $table.titre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get citation => $composableBuilder(
    column: $table.citation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceSource => $composableBuilder(
    column: $table.referenceSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lettreLieeId => $composableBuilder(
    column: $table.lettreLieeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioExtraitUrl => $composableBuilder(
    column: $table.audioExtraitUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceKey => $composableBuilder(
    column: $table.sourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remoteAvailable => $composableBuilder(
    column: $table.remoteAvailable,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyWordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyWordsTable> {
  $$DailyWordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dateLocale => $composableBuilder(
    column: $table.dateLocale,
    builder: (column) => column,
  );

  GeneratedColumn<String> get langue =>
      $composableBuilder(column: $table.langue, builder: (column) => column);

  GeneratedColumn<String> get titre =>
      $composableBuilder(column: $table.titre, builder: (column) => column);

  GeneratedColumn<String> get citation =>
      $composableBuilder(column: $table.citation, builder: (column) => column);

  GeneratedColumn<String> get referenceSource => $composableBuilder(
    column: $table.referenceSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lettreLieeId => $composableBuilder(
    column: $table.lettreLieeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioExtraitUrl => $composableBuilder(
    column: $table.audioExtraitUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceKey =>
      $composableBuilder(column: $table.sourceKey, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<bool> get remoteAvailable => $composableBuilder(
    column: $table.remoteAvailable,
    builder: (column) => column,
  );
}

class $$DailyWordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyWordsTable,
          DailyWordRow,
          $$DailyWordsTableFilterComposer,
          $$DailyWordsTableOrderingComposer,
          $$DailyWordsTableAnnotationComposer,
          $$DailyWordsTableCreateCompanionBuilder,
          $$DailyWordsTableUpdateCompanionBuilder,
          (
            DailyWordRow,
            BaseReferences<_$AppDatabase, $DailyWordsTable, DailyWordRow>,
          ),
          DailyWordRow,
          PrefetchHooks Function()
        > {
  $$DailyWordsTableTableManager(_$AppDatabase db, $DailyWordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyWordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyWordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyWordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dateLocale = const Value.absent(),
                Value<String> langue = const Value.absent(),
                Value<String> titre = const Value.absent(),
                Value<String> citation = const Value.absent(),
                Value<String> referenceSource = const Value.absent(),
                Value<String?> lettreLieeId = const Value.absent(),
                Value<String?> audioExtraitUrl = const Value.absent(),
                Value<String> sourceKey = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<bool> remoteAvailable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyWordsCompanion(
                id: id,
                dateLocale: dateLocale,
                langue: langue,
                titre: titre,
                citation: citation,
                referenceSource: referenceSource,
                lettreLieeId: lettreLieeId,
                audioExtraitUrl: audioExtraitUrl,
                sourceKey: sourceKey,
                statut: statut,
                remoteAvailable: remoteAvailable,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dateLocale,
                Value<String> langue = const Value.absent(),
                required String titre,
                required String citation,
                required String referenceSource,
                Value<String?> lettreLieeId = const Value.absent(),
                Value<String?> audioExtraitUrl = const Value.absent(),
                required String sourceKey,
                Value<String> statut = const Value.absent(),
                Value<bool> remoteAvailable = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyWordsCompanion.insert(
                id: id,
                dateLocale: dateLocale,
                langue: langue,
                titre: titre,
                citation: citation,
                referenceSource: referenceSource,
                lettreLieeId: lettreLieeId,
                audioExtraitUrl: audioExtraitUrl,
                sourceKey: sourceKey,
                statut: statut,
                remoteAvailable: remoteAvailable,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DailyWordsTable, DailyWordRow>(table),
                  BaseReferences<_$AppDatabase, $DailyWordsTable, DailyWordRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyWordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyWordsTable,
      DailyWordRow,
      $$DailyWordsTableFilterComposer,
      $$DailyWordsTableOrderingComposer,
      $$DailyWordsTableAnnotationComposer,
      $$DailyWordsTableCreateCompanionBuilder,
      $$DailyWordsTableUpdateCompanionBuilder,
      (
        DailyWordRow,
        BaseReferences<_$AppDatabase, $DailyWordsTable, DailyWordRow>,
      ),
      DailyWordRow,
      PrefetchHooks Function()
    >;
typedef $$DownloadJobsTableCreateCompanionBuilder =
    DownloadJobsCompanion Function({
      Value<int> id,
      required String letterId,
      required String fileType,
      required String remoteUrl,
      required String fileName,
      Value<String> status,
      Value<int> bytesReceived,
      Value<int?> totalBytes,
      Value<String?> sha256,
      Value<String?> localPath,
      Value<String?> error,
      Value<int> attempts,
      Value<DateTime> updatedAt,
    });
typedef $$DownloadJobsTableUpdateCompanionBuilder =
    DownloadJobsCompanion Function({
      Value<int> id,
      Value<String> letterId,
      Value<String> fileType,
      Value<String> remoteUrl,
      Value<String> fileName,
      Value<String> status,
      Value<int> bytesReceived,
      Value<int?> totalBytes,
      Value<String?> sha256,
      Value<String?> localPath,
      Value<String?> error,
      Value<int> attempts,
      Value<DateTime> updatedAt,
    });

class $$DownloadJobsTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadJobsTable> {
  $$DownloadJobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get letterId => $composableBuilder(
    column: $table.letterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bytesReceived => $composableBuilder(
    column: $table.bytesReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DownloadJobsTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadJobsTable> {
  $$DownloadJobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get letterId => $composableBuilder(
    column: $table.letterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bytesReceived => $composableBuilder(
    column: $table.bytesReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DownloadJobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadJobsTable> {
  $$DownloadJobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get letterId =>
      $composableBuilder(column: $table.letterId, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get bytesReceived => $composableBuilder(
    column: $table.bytesReceived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalBytes => $composableBuilder(
    column: $table.totalBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DownloadJobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DownloadJobsTable,
          DownloadJob,
          $$DownloadJobsTableFilterComposer,
          $$DownloadJobsTableOrderingComposer,
          $$DownloadJobsTableAnnotationComposer,
          $$DownloadJobsTableCreateCompanionBuilder,
          $$DownloadJobsTableUpdateCompanionBuilder,
          (
            DownloadJob,
            BaseReferences<_$AppDatabase, $DownloadJobsTable, DownloadJob>,
          ),
          DownloadJob,
          PrefetchHooks Function()
        > {
  $$DownloadJobsTableTableManager(_$AppDatabase db, $DownloadJobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadJobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadJobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadJobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> letterId = const Value.absent(),
                Value<String> fileType = const Value.absent(),
                Value<String> remoteUrl = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> bytesReceived = const Value.absent(),
                Value<int?> totalBytes = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DownloadJobsCompanion(
                id: id,
                letterId: letterId,
                fileType: fileType,
                remoteUrl: remoteUrl,
                fileName: fileName,
                status: status,
                bytesReceived: bytesReceived,
                totalBytes: totalBytes,
                sha256: sha256,
                localPath: localPath,
                error: error,
                attempts: attempts,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String letterId,
                required String fileType,
                required String remoteUrl,
                required String fileName,
                Value<String> status = const Value.absent(),
                Value<int> bytesReceived = const Value.absent(),
                Value<int?> totalBytes = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<String?> localPath = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DownloadJobsCompanion.insert(
                id: id,
                letterId: letterId,
                fileType: fileType,
                remoteUrl: remoteUrl,
                fileName: fileName,
                status: status,
                bytesReceived: bytesReceived,
                totalBytes: totalBytes,
                sha256: sha256,
                localPath: localPath,
                error: error,
                attempts: attempts,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DownloadJobsTable, DownloadJob>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DownloadJobsTable,
                    DownloadJob
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DownloadJobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DownloadJobsTable,
      DownloadJob,
      $$DownloadJobsTableFilterComposer,
      $$DownloadJobsTableOrderingComposer,
      $$DownloadJobsTableAnnotationComposer,
      $$DownloadJobsTableCreateCompanionBuilder,
      $$DownloadJobsTableUpdateCompanionBuilder,
      (
        DownloadJob,
        BaseReferences<_$AppDatabase, $DownloadJobsTable, DownloadJob>,
      ),
      DownloadJob,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LettersTableTableManager get letters =>
      $$LettersTableTableManager(_db, _db.letters);
  $$DailyWordsTableTableManager get dailyWords =>
      $$DailyWordsTableTableManager(_db, _db.dailyWords);
  $$DownloadJobsTableTableManager get downloadJobs =>
      $$DownloadJobsTableTableManager(_db, _db.downloadJobs);
}
