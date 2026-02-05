import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/main_shell.dart';
import '../screens/home/home_screen.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/wallpaper_detail/wallpaper_detail_screen.dart';
import '../screens/tag/tag_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/policy/privacy_policy_screen.dart';
import '../screens/policy/terms_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String gallery = '/gallery';
  static const String favorites = '/favorites';
  static const String wallpaperDetail = '/wallpaper/:id';
  static const String tag = '/tag/:slug';
  static const String settings = '/settings';
  static const String privacy = '/privacy';
  static const String terms = '/terms';

  static String wallpaperPath(String id) => '/wallpaper/$id';
  static String tagPath(String slug) => '/tag/$slug';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home,
  routes: [
    // Main shell with bottom navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.gallery,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: GalleryScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.favorites,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: FavoritesScreen(),
          ),
        ),
      ],
    ),
    // Full screen routes (pushed over shell)
    GoRoute(
      path: AppRoutes.wallpaperDetail,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return WallpaperDetailScreen(wallpaperId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.tag,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;
        final name = state.uri.queryParameters['name'];
        return TagScreen(tagSlug: slug, tagName: name);
      },
    ),
    GoRoute(
      path: AppRoutes.settings,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.privacy,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.terms,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const TermsScreen(),
    ),
  ],
);
