import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../config/constants.dart';

enum WallpaperTarget { home, lock, both }

class WallpaperResult {
  final bool success;
  final String message;
  final bool requiresManualAction;
  final String? errorCode;

  WallpaperResult({
    required this.success,
    required this.message,
    this.requiresManualAction = false,
    this.errorCode,
  });
}

class WallpaperService {
  static const _channel = MethodChannel(AppConstants.wallpaperChannel);

  Future<WallpaperResult> setWallpaper(
    String imageUrl, {
    WallpaperTarget target = WallpaperTarget.both,
  }) async {
    // Web doesn't support setting wallpapers
    if (kIsWeb) {
      return WallpaperResult(
        success: false,
        message: 'Setting wallpaper is not supported on web. Please download the image instead.',
        requiresManualAction: true,
      );
    }

    try {
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'setWallpaper',
        {
          'url': imageUrl,
          'target': target.name,
        },
      );

      return WallpaperResult(
        success: result?['success'] == true,
        message: result?['message']?.toString() ?? 'Unknown result',
        requiresManualAction: result?['requiresManualAction'] == true,
      );
    } on PlatformException catch (e) {
      return WallpaperResult(
        success: false,
        message: e.message ?? 'Failed to set wallpaper',
        errorCode: e.code,
      );
    } catch (e) {
      return WallpaperResult(
        success: false,
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  bool get canSetWallpaperDirectly =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  bool get requiresManualWallpaperSet =>
      kIsWeb || defaultTargetPlatform == TargetPlatform.iOS;
}
