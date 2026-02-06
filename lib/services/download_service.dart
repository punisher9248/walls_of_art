import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
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
  final Dio _dio = Dio();

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
      // Request permission
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

      // Get the download directory
      final directory = await _getDownloadDirectory();
      if (directory == null) {
        return DownloadResult(
          success: false,
          message: 'Could not access download directory',
        );
      }

      // Generate file name from URL if not provided
      final name = fileName ?? _getFileNameFromUrl(imageUrl);
      final filePath = '${directory.path}/$name';

      // Check if file already exists
      final file = File(filePath);
      if (await file.exists()) {
        return DownloadResult(
          success: true,
          message: 'Wallpaper already downloaded',
          filePath: filePath,
        );
      }

      // Download the file
      await _dio.download(
        imageUrl,
        filePath,
        onReceiveProgress: onProgress,
        options: Options(
          headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          },
        ),
      );

      return DownloadResult(
        success: true,
        message: 'Wallpaper saved to gallery',
        filePath: filePath,
      );
    } on DioException catch (e) {
      return DownloadResult(
        success: false,
        message: 'Download failed: ${e.message}',
      );
    } catch (e) {
      return DownloadResult(
        success: false,
        message: 'Download failed: $e',
      );
    }
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      // Use app-specific external directory (works on all Android versions
      // without extra permissions)
      final externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        // Try shared Pictures directory for visibility in gallery
        final picturesPath = externalDir.path.replaceFirst(
          RegExp(r'/Android/data/[^/]+/files'),
          '/Pictures/WallsOfArt',
        );
        final picturesDir = Directory(picturesPath);
        try {
          if (!await picturesDir.exists()) {
            await picturesDir.create(recursive: true);
          }
          return picturesDir;
        } catch (_) {
          // Shared storage not accessible (Android 10+ scoped storage),
          // fall back to app-specific directory
          final appDir = Directory('${externalDir.path}/WallsOfArt');
          if (!await appDir.exists()) {
            await appDir.create(recursive: true);
          }
          return appDir;
        }
      }
      return await getApplicationDocumentsDirectory();
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  String _getFileNameFromUrl(String url) {
    final uri = Uri.parse(url);
    final pathSegments = uri.pathSegments;
    if (pathSegments.isNotEmpty) {
      final lastSegment = pathSegments.last;
      if (lastSegment.contains('.')) {
        return lastSegment;
      }
    }
    return 'wallpaper_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
}
