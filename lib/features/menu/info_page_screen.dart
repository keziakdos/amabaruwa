import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/state_views.dart';
import 'menu_content.dart';

class InfoPageScreen extends StatelessWidget {
  const InfoPageScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final page = InfoPage.bySlug(slug);

    if (page == null) {
      return Scaffold(
        appBar: AppBar(),
        body: EmptyState(title: l10n.letterNotFound),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(page.title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(l10n.attribution, style: Theme.of(context).textTheme.bodySmall),
          const Divider(height: 28),
          for (final section in page.sections) ...[
            if (section.heading != null) ...[
              Text(
                section.heading!,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900, height: 1.4),
              ),
              const SizedBox(height: 8),
            ],
            SelectableText(
              section.text,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontSize: 17, height: 1.6),
            ),
            const SizedBox(height: 18),
          ],
          if (page.contactEmail != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      page.contactEmail!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppColors.night,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => launchUrl(
                          Uri(scheme: 'mailto', path: page.contactEmail),
                          mode: LaunchMode.externalApplication,
                        ),
                        icon: const Icon(Icons.mail_outline_rounded, size: 18),
                        label: Text(l10n.contactUs),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
          OutlinedButton.icon(
            onPressed: () => launchUrl(
              Uri.parse(page.url),
              mode: LaunchMode.externalApplication,
            ),
            icon: const Icon(Icons.open_in_new_rounded, size: 18),
            label: Text(l10n.sourcePage),
          ),
          const SizedBox(height: 18),
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
