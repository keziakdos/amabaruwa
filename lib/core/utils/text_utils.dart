import 'package:html/parser.dart' as html_parser;

String htmlToPlainText(String value) {
  if (value.trim().isEmpty) {
    return '';
  }
  final document = html_parser.parse(value);
  final text = document.documentElement?.text ?? '';
  return text.replaceAll(RegExp(r'\s+'), ' ').trim();
}

String previewText(String html, {int maxLength = 130}) {
  final text = htmlToPlainText(html);
  if (text.length <= maxLength) {
    return text;
  }
  return '${text.substring(0, maxLength).trimRight()}…';
}

String formatDuration(Duration value) {
  final totalSeconds = value.inSeconds;
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;
  final mm = minutes.toString().padLeft(2, '0');
  final ss = seconds.toString().padLeft(2, '0');
  if (hours > 0) {
    return '$hours:$mm:$ss';
  }
  return '$minutes:$ss';
}

String formatBytes(int? bytes) {
  if (bytes == null || bytes <= 0) {
    return '—';
  }
  const units = ['o', 'Ko', 'Mo', 'Go'];
  var value = bytes.toDouble();
  var unit = 0;
  while (value >= 1024 && unit < units.length - 1) {
    value /= 1024;
    unit++;
  }
  final rounded = value >= 10 || unit == 0
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(1);
  return '$rounded ${units[unit]}';
}
