import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/downloads/downloads_screen.dart';
import '../features/home/home_screen.dart';
import '../features/letters/letter_detail_screen.dart';
import '../features/letters/letters_screen.dart';
import '../features/letters/pdf_screen.dart';
import '../features/player/player_screen.dart';
import '../features/settings/settings_screen.dart';
import 'shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/letters',
                builder: (context, state) => const LettersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/downloads',
                builder: (context, state) => const DownloadsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/letter/:id',
        parentNavigatorKey: rootKey,
        builder: (context, state) {
          return LetterDetailScreen(letterId: state.pathParameters['id']!);
        },
      ),
      GoRoute(
        path: '/letter/:id/pdf',
        parentNavigatorKey: rootKey,
        builder: (context, state) {
          return PdfScreen(letterId: state.pathParameters['id']!);
        },
      ),
      GoRoute(
        path: '/player',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const PlayerScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
