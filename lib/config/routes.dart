import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/main_shell.dart';
import '../screens/home/home_screen.dart';
import '../screens/gallery/gallery_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/wallpaper_detail/wallpaper_detail_screen.dart';
import '../screens/tag/tag_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/policy/privacy_policy_screen.dart';
import '../screens/policy/terms_screen.dart';

// class AppRoutes {
//   AppRoutes._();
//
//   static const String splash = '/splash';
//
//   static const String home = '/';
//   static const String gallery = '/gallery';
//   static const String favorites = '/favorites';
//   static const String wallpaperDetail = '/wallpaper/:id';
//   static const String tag = '/tag/:slug';
//   static const String settings = '/settings';
//   static const String privacy = '/privacy';
//   static const String terms = '/terms';
//
//   static String wallpaperPath(String id) => '/wallpaper/$id';
//   static String tagPath(String slug) => '/tag/$slug';
// }
//
// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>();
//
// final GoRouter appRouter = GoRouter(
//   navigatorKey: _rootNavigatorKey,
//   initialLocation: AppRoutes.splash,
//   routes: [
//
//     // Splash (NO shell, NO bottom bar)
//     GoRoute(
//       path: AppRoutes.splash,
//       builder: (context, state) => const SplashScreen(),
//     ),
//
//     // Main shell with bottom navigation
//     ShellRoute(
//       navigatorKey: _shellNavigatorKey,
//       builder: (context, state, child) => MainShell(child: child),
//       routes: [
//         GoRoute(
//           path: AppRoutes.home,
//           pageBuilder: (context, state) => const NoTransitionPage(
//             child: HomeScreen(),
//           ),
//         ),
//         GoRoute(
//           path: AppRoutes.gallery,
//           pageBuilder: (context, state) => const NoTransitionPage(
//             child: GalleryScreen(),
//           ),
//         ),
//         GoRoute(
//           path: AppRoutes.favorites,
//           pageBuilder: (context, state) => const NoTransitionPage(
//             child: FavoritesScreen(),
//           ),
//         ),
//       ],
//     ),
//     // Full screen routes (pushed over shell)
//     GoRoute(
//       path: AppRoutes.wallpaperDetail,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return WallpaperDetailScreen(wallpaperId: id);
//       },
//     ),
//     GoRoute(
//       path: AppRoutes.tag,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) {
//         final slug = state.pathParameters['slug']!;
//         final name = state.uri.queryParameters['name'];
//         return TagScreen(tagSlug: slug, tagName: name);
//       },
//     ),
//     GoRoute(
//       path: AppRoutes.settings,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) => const SettingsScreen(),
//     ),
//     GoRoute(
//       path: AppRoutes.privacy,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) => const PrivacyPolicyScreen(),
//     ),
//     GoRoute(
//       path: AppRoutes.terms,
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) => const TermsScreen(),
//     ),
//   ],
// );



class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
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
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    // Splash screen (full screen)
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 700),
      ),
    ),

    // Main shell with bottom navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final fade = Tween<double>(begin: 0, end: 1).animate(animation);
              return FadeTransition(opacity: fade, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ),
        GoRoute(
          path: AppRoutes.gallery,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const GalleryScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final fade = Tween<double>(begin: 0, end: 1).animate(animation);
              return FadeTransition(opacity: fade, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ),
        GoRoute(
          path: AppRoutes.favorites,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const FavoritesScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final fade = Tween<double>(begin: 0, end: 1).animate(animation);
              return FadeTransition(opacity: fade, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        ),
      ],
    ),

    // Full screen routes pushed over shell
    GoRoute(
      path: AppRoutes.wallpaperDetail,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return CustomTransitionPage(
          key: state.pageKey,
          child: WallpaperDetailScreen(wallpaperId: id),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = Tween<double>(begin: 0, end: 1).animate(animation);
            return FadeTransition(opacity: fade, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.tag,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final slug = state.pathParameters['slug']!;
        final name = state.uri.queryParameters['name'];
        return CustomTransitionPage(
          key: state.pageKey,
          child: TagScreen(tagSlug: slug, tagName: name),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = Tween<double>(begin: 0, end: 1).animate(animation);
            return FadeTransition(opacity: fade, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.settings,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ),
    GoRoute(
      path: AppRoutes.privacy,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PrivacyPolicyScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ),
    GoRoute(
      path: AppRoutes.terms,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const TermsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    ),
  ],
);
