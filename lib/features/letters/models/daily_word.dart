class DailyWord {
  const DailyWord({
    required this.id,
    required this.dateLocale,
    required this.langue,
    required this.titre,
    required this.citation,
    required this.referenceSource,
    required this.sourceKey,
    required this.statut,
    this.lettreLieeId,
    this.audioExtraitUrl,
    this.remoteAvailable = true,
  });

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

  bool get hasAudio => audioExtraitUrl != null && audioExtraitUrl!.isNotEmpty;

  DailyWord copyWith({bool? remoteAvailable}) {
    return DailyWord(
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
      remoteAvailable: remoteAvailable ?? this.remoteAvailable,
    );
  }
}
