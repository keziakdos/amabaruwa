import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/kigali_date.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/section_header.dart';
import '../letters/data/sync_controller.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final sync = ref.watch(syncControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          SectionHeader(title: l10n.theme, padding: EdgeInsets.zero),
          Card(
            child: RadioGroup<ThemeMode>(
              groupValue: settings.themeMode,
              onChanged: (value) {
                if (value != null) {
                  ref
                      .read(settingsControllerProvider.notifier)
                      .setThemeMode(value);
                }
              },
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    title: Text(l10n.themeSystem),
                    secondary: const Icon(Icons.brightness_auto_outlined),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    title: Text(l10n.themeLight),
                    secondary: const Icon(Icons.light_mode_outlined),
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    title: Text(l10n.themeDark),
                    secondary: const Icon(Icons.dark_mode_outlined),
                  ),
                ],
              ),
            ),
          ),
          SectionHeader(title: l10n.readingSettings),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(l10n.fontSize)),
                      Text(
                        settings.fontSize.round().toString(),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Slider(
                    value: settings.fontSize,
                    min: AppConfig.minFontSize,
                    max: AppConfig.maxFontSize,
                    divisions: 6,
                    onChanged: (value) => ref
                        .read(settingsControllerProvider.notifier)
                        .setFontSize(value),
                  ),
                ],
              ),
            ),
          ),
          SectionHeader(title: l10n.dataSync),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.schedule_rounded),
                  title: Text(l10n.lastSync),
                  subtitle: Text(
                    sync.lastSync == null
                        ? l10n.neverSynced
                        : _formatDate(sync.lastSync!),
                  ),
                ),
                if (sync.error != null)
                  ListTile(
                    leading: const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.danger,
                    ),
                    title: Text(sync.error!),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: sync.syncing
                          ? null
                          : () => ref
                                .read(syncControllerProvider.notifier)
                                .syncNow(),
                      icon: sync.syncing
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.night,
                              ),
                            )
                          : const Icon(Icons.sync_rounded),
                      label: Text(l10n.syncNow),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SectionHeader(title: l10n.about),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(l10n.languageName),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(l10n.version(AppConfig.appVersion)),
                ),
                ListTile(
                  leading: const Icon(Icons.public_rounded),
                  title: Text(l10n.source),
                  subtitle: const Text(AppConfig.sourceName),
                  trailing: const Icon(Icons.open_in_new_rounded, size: 18),
                  onTap: () => launchUrl(
                    Uri.parse(AppConfig.sourceSite),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(l10n.licenses),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: l10n.appName,
                    applicationVersion: AppConfig.appVersion,
                    applicationLegalese: l10n.attribution,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime value) {
    final local = value.toLocal();
    return '${local.day} ${formatKigaliDateText('${local.year}-${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')}').split(' ').sublist(1).join(' ')}'
        ' ${local.hour.toString().padLeft(2, '0')}:'
        '${local.minute.toString().padLeft(2, '0')}';
  }
}
