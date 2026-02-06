import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../config/constants.dart';
import 'permission_service.dart';

class DownloadResult {
  final bool success;
  final String message;
  final String? filePath;
  final bool permissionDenied;
  final bool permissionPermanentlyDenied;

  DownloadResult({
    required this.success,
    required this.message,
    this.filePath,
    this.permissionDenied = false,
    this.permissionPermanentlyDenied = false,
  });
}

class DownloadService {
  static const _channel = MethodChannel(AppConstants.wallpaperChannel);

  Future<DownloadResult> downloadWallpaper(
    String imageUrl, {
    String? fileName,
    void Function(int received, int total)? onProgress,
  }) async {
    if (kIsWeb) {
      return DownloadResult(
        success: false,
        message: 'Download not supported on web. Right-click the image to save.',
      );
    }

    try {
      // Request permission first
      final permResult = await PermissionService.requestSavePermission();

      if (permResult == PermissionResult.permanentlyDenied) {
        return DownloadResult(
          success: false,
          message: 'Storage permission is required. Please enable it in Settings.',
          permissionDenied: true,
          permissionPermanentlyDenied: true,
        );
      }

      if (permResult == PermissionResult.denied) {
        return DownloadResult(
          success: false,
          message: 'Storage permission is required to save wallpapers.',
          permissionDenied: true,
        );
      }

      // Save directly to gallery via native platform channel
      final result = await _channel.invokeMethod<Map<dynamic, dynamic>>(
        'saveToGallery',
        {
          'url': imageUrl,
          'fileName': fileName ?? 'wallpaper_${DateTime.now().millisecondsSinceEpoch}.jpg',
        },
      );

      return DownloadResult(
        success: result?['success'] == true,
        message: result?['message']?.toString() ?? 'Unknown result',
      );
    } on PlatformException catch (e) {
      return DownloadResult(
        success: false,
        message: e.message ?? 'Failed to save image',
      );
    } catch (e) {
      return DownloadResult(
        success: false,
        message: 'Failed to save: $e',
      );
    }
  }
}
