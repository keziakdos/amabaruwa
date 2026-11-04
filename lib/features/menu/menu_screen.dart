import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import 'menu_content.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      (
        page: InfoPage.nyirikwandika,
        icon: Icons.edit_note_rounded,
        description: l10n.menuNyirikwandikaDescription,
      ),
      (
        page: InfoPage.beneBudama,
        icon: Icons.groups_rounded,
        description: l10n.menuBeneBudamaDescription,
      ),
      (
        page: InfoPage.kudutumaho,
        icon: Icons.mail_outline_rounded,
        description: l10n.menuKudutumahoDescription,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.menu)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Text(
            l10n.menuIntro,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.muted, height: 1.5),
          ),
          const SizedBox(height: 18),
          for (final item in items) ...[
            Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => context.push('/menu/${item.page.slug}'),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 10, 14),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: AppColors.headerGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(item.icon, color: AppColors.night),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.page.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.muted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.muted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          Text(
            l10n.attribution,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
