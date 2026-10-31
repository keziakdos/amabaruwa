import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/text_utils.dart';

class LetterContent extends StatelessWidget {
  const LetterContent({
    super.key,
    required this.html,
    required this.fontSize,
    required this.color,
  });

  final String html;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final document = html_parser.parse(html);
    final elements = document.querySelectorAll(
      'p, h1, h2, h3, h4, h5, h6, li, blockquote',
    );

    if (elements.isEmpty) {
      final plain = htmlToPlainText(html);
      if (plain.isEmpty) {
        return const SizedBox.shrink();
      }
      return SelectableText(plain, style: _style());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final element in elements)
          if (_textOf(element).isNotEmpty) _block(context, element),
      ],
    );
  }

  Widget _block(BuildContext context, dom.Element element) {
    final tag = element.localName ?? 'p';
    final text = _textOf(element);
    if (tag == 'li') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: fontSize * 0.55),
              child: Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: SelectableText(text, style: _style())),
          ],
        ),
      );
    }

    if (tag.startsWith('h')) {
      final level = int.tryParse(tag.substring(1)) ?? 2;
      final headingSize =
          fontSize +
          (level == 1
              ? 8
              : level == 2
              ? 4
              : 2);
      return Padding(
        padding: EdgeInsets.only(top: level <= 2 ? 20 : 16, bottom: 8),
        child: SelectableText(
          text,
          style: _style(
            size: headingSize,
            weight: FontWeight.w900,
            height: 1.35,
          ),
        ),
      );
    }

    if (tag == 'blockquote') {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
        decoration: const BoxDecoration(
          color: AppColors.mist,
          border: Border(left: BorderSide(color: AppColors.gold, width: 4)),
        ),
        child: SelectableText(text, style: _style()),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SelectableText(text, style: _style()),
    );
  }

  TextStyle _style({
    double? size,
    FontWeight weight = FontWeight.w400,
    double height = 1.65,
  }) {
    return TextStyle(
      fontFamily: 'Lato',
      fontSize: size ?? fontSize,
      fontWeight: weight,
      height: height,
      color: color,
    );
  }

  String _textOf(dom.Element element) {
    return element.text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
