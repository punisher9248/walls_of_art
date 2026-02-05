class AppConstants {
  AppConstants._();

  // API Configuration
  static const String baseUrl = 'https://walls-of-art.vercel.app/api';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int defaultPageSize = 50;
  static const int maxPageSize = 100;

  // Cache Configuration
  static const String thumbnailCacheKey = 'wallpaper_thumbnails';
  static const int thumbnailMaxAgeDays = 7;
  static const int thumbnailMaxItems = 500;

  static const String fullImageCacheKey = 'wallpaper_full';
  static const int fullImageMaxAgeDays = 30;
  static const int fullImageMaxItems = 100;

  // Ad Configuration
  static const int interstitialFrequency = 3; // Show after every 3 wallpaper sets
  static const int bannerAdInterval = 20; // Show banner every 20 items in grid

  // Storage Keys
  static const String favoritesKey = 'favorite_wallpaper_ids';
  static const String lastSyncKey = 'favorites_last_sync';

  // Platform Channel
  static const String wallpaperChannel = 'com.wallsofart/wallpaper';

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Grid Configuration
  static const int mobileColumns = 2;
  static const int tabletColumns = 3;
  static const int desktopColumns = 4;

  // Aspect Ratios
  static const double wallpaperAspectRatio = 9 / 16;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 150);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
