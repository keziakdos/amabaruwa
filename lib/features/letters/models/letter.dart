class Letter {
  const Letter({
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
    this.audioPositionSeconds = 0,
    this.isFavorite = false,
    this.readingProgress = 0,
    this.lastReadAt,
    this.remoteAvailable = true,
  });

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

  bool get hasPdf => pdfUrl != null && pdfUrl!.isNotEmpty;
  bool get hasAudio => audioUrl != null && audioUrl!.isNotEmpty;
  bool get hasText => contenuHtml.trim().isNotEmpty;

  Letter copyWith({
    String? id,
    int? numero,
    String? slug,
    String? langue,
    String? titre,
    String? contenuHtml,
    String? statut,
    String? pdfFile,
    String? pdfUrl,
    String? audioFile,
    String? audioUrl,
    String? urlOrigine,
    String? sourceKey,
    String? pdfSha256,
    String? audioSha256,
    DateTime? sourceModifiedAt,
    int? pdfSizeBytes,
    int? audioSizeBytes,
    double? audioDurationSeconds,
    double? audioPositionSeconds,
    bool? isFavorite,
    double? readingProgress,
    DateTime? lastReadAt,
    bool? remoteAvailable,
  }) {
    return Letter(
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
    );
  }
}
