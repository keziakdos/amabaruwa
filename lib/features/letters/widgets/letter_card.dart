import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/text_utils.dart';
import '../../../l10n/app_localizations.dart';
import '../models/letter.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({
    super.key,
    required this.letter,
    required this.onTap,
    required this.onFavorite,
    this.pdfOffline = false,
    this.audioOffline = false,
  });

  final Letter letter;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final bool pdfOffline;
  final bool audioOffline;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final preview = previewText(letter.contenuHtml);

    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 13, 8, 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.headerGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${letter.numero}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    color: AppColors.night,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      letter.titre,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                    if (preview.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (letter.hasPdf)
                          _Badge(label: 'PDF', offline: pdfOffline),
                        if (letter.hasAudio)
                          _Badge(label: l10n.audioShort, offline: audioOffline),
                        if (!letter.remoteAvailable)
                          _Badge(label: l10n.unavailableOnServer),
                      ],
                    ),
                    if (letter.readingProgress > 0) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: letter.readingProgress.clamp(0, 1),
                          minHeight: 4,
                          backgroundColor: AppColors.mist,
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavorite,
                tooltip: letter.isFavorite
                    ? l10n.favoriteRemoved
                    : l10n.favoriteAdded,
                icon: Icon(
                  letter.isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: letter.isFavorite
                      ? AppColors.gold
                      : AppColors.disabled,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, this.offline = false});

  final String label;
  final bool offline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: offline ? const Color(0xFFFFF3C9) : AppColors.mist,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (offline) ...[
            const Icon(
              Icons.offline_pin_rounded,
              size: 11,
              color: AppColors.amberText,
            ),
            const SizedBox(width: 3),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: offline ? AppColors.amberText : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
