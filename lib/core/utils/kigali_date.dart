const Duration _kigaliOffset = Duration(hours: 2);

/// Jour éditorial Africa/Kigali (UTC+2, sans heure d'été).
DateTime kigaliNow([DateTime? reference]) {
  final utc = (reference ?? DateTime.now()).toUtc();
  final shifted = utc.add(_kigaliOffset);
  return DateTime(
    shifted.year,
    shifted.month,
    shifted.day,
    shifted.hour,
    shifted.minute,
    shifted.second,
  );
}

String kigaliDateKey([DateTime? reference]) {
  final d = kigaliNow(reference);
  final month = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '${d.year}-$month-$day';
}

const List<String> _months = [
  'Mutarama',
  'Gashyantare',
  'Werurwe',
  'Mata',
  'Gicurasi',
  'Kamena',
  'Nyakanga',
  'Kanama',
  'Nzeli',
  'Ukwakira',
  'Ugushyingo',
  'Ukuboza',
];

String formatKigaliDateText(String dateLocale) {
  final parts = dateLocale.split('-');
  if (parts.length != 3) {
    return dateLocale;
  }
  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);
  if (year == null || month == null || day == null) {
    return dateLocale;
  }
  if (month < 1 || month > 12) {
    return dateLocale;
  }
  return '$day ${_months[month - 1]} $year';
}

DateTime? parsePocketBaseDate(Object? value) {
  if (value is! String || value.trim().isEmpty) {
    return null;
  }
  return DateTime.tryParse(value.replaceFirst(' ', 'T'))?.toLocal();
}
