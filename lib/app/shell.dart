import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/letters/data/sync_controller.dart';
import '../l10n/app_localizations.dart';
import '../shared/widgets/mini_player.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(syncControllerProvider.notifier).syncNow();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final index = widget.navigationShell.currentIndex;

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayerBar(),
          NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (value) {
              widget.navigationShell.goBranch(
                value,
                initialLocation: value == widget.navigationShell.currentIndex,
              );
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: l10n.navHome,
              ),
              NavigationDestination(
                icon: const Icon(Icons.menu_book_outlined),
                selectedIcon: const Icon(Icons.menu_book_rounded),
                label: l10n.navLetters,
              ),
              NavigationDestination(
                icon: const Icon(Icons.download_outlined),
                selectedIcon: const Icon(Icons.download_rounded),
                label: l10n.navDownloads,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShellNavigatorKeys {
  const ShellNavigatorKeys._();
}
