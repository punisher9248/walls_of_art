import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadResult {
  final bool success;
  final String message;
  final String? filePath;

  DownloadResult({
    required this.success,
    required this.message,
    this.filePath,
  });
}

class DownloadService {
  final Dio _dio = Dio();

  Future<DownloadResult> downloadWallpaper(
    String imageUrl, {
    String? fileName,
    void Function(int received, int total)? onProgress,
  }) async {
    // Web doesn't support direct downloads this way
    if (kIsWeb) {
      return DownloadResult(
        success: false,
        message: 'Download not supported on web. Right-click the image to save.',
      );
    }

    try {
      // Request storage permission on Android
      if (Platform.isAndroid) {
        final status = await _requestStoragePermission();
        if (!status) {
          return DownloadResult(
            success: false,
            message: 'Storage permission denied. Please grant permission in settings.',
          );
        }
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

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13+ (API 33+), we need different permissions
      final androidInfo = await _getAndroidSdkVersion();

      if (androidInfo >= 33) {
        // Android 13+ uses granular media permissions
        final photos = await Permission.photos.request();
        return photos.isGranted;
      } else if (androidInfo >= 30) {
        // Android 11-12 uses MANAGE_EXTERNAL_STORAGE or scoped storage
        final storage = await Permission.storage.request();
        return storage.isGranted;
      } else {
        // Android 10 and below
        final storage = await Permission.storage.request();
        return storage.isGranted;
      }
    }
    return true;
  }

  Future<int> _getAndroidSdkVersion() async {
    if (Platform.isAndroid) {
      // This is a simplified version - in production you'd use device_info_plus
      return 33; // Assume modern Android
    }
    return 0;
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      // Use Pictures directory for wallpapers
      final externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        // Navigate to Pictures/WallsOfArt
        final picturesPath = externalDir.path.replaceFirst(
          RegExp(r'/Android/data/[^/]+/files'),
          '/Pictures/WallsOfArt',
        );
        final picturesDir = Directory(picturesPath);
        if (!await picturesDir.exists()) {
          await picturesDir.create(recursive: true);
        }
        return picturesDir;
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
    // Fallback: generate a name based on timestamp
    return 'wallpaper_${DateTime.now().millisecondsSinceEpoch}.jpg';
  }
}
