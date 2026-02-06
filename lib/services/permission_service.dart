import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionResult { granted, denied, permanentlyDenied }

class PermissionService {
  /// Requests the appropriate permission for saving images to device storage.
  ///
  /// - Android <13: Requests WRITE_EXTERNAL_STORAGE
  /// - Android 13+: Storage permission is restricted; no runtime permission
  ///   needed for saving via app-specific directory
  /// - iOS: Requests add-only photo library access
  static Future<PermissionResult> requestSavePermission() async {
    if (kIsWeb) return PermissionResult.granted;

    if (Platform.isAndroid) {
      return _requestAndroidSavePermission();
    } else if (Platform.isIOS) {
      return _requestIOSPhotoPermission();
    }

    return PermissionResult.granted;
  }

  static Future<PermissionResult> _requestAndroidSavePermission() async {
    // First check Permission.photos (READ_MEDIA_IMAGES) for Android 13+
    var status = await Permission.photos.status;

    if (status.isGranted) return PermissionResult.granted;

    // If photos permission is not applicable (older Android),
    // status will be denied. Try Permission.storage instead.
    if (status.isDenied) {
      // Try requesting photos first (Android 13+)
      status = await Permission.photos.request();
      if (status.isGranted) return PermissionResult.granted;

      // If photos was denied immediately (could be older Android where
      // this permission doesn't exist), try storage permission
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) return PermissionResult.granted;

      if (!storageStatus.isPermanentlyDenied) {
        final result = await Permission.storage.request();
        if (result.isGranted) return PermissionResult.granted;
        if (result.isPermanentlyDenied) {
          return PermissionResult.permanentlyDenied;
        }
        return PermissionResult.denied;
      }
    }

    if (status.isPermanentlyDenied) {
      // Also check if storage is permanently denied
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) return PermissionResult.granted;
      return PermissionResult.permanentlyDenied;
    }

    return PermissionResult.denied;
  }

  static Future<PermissionResult> _requestIOSPhotoPermission() async {
    var status = await Permission.photosAddOnly.status;

    if (status.isGranted || status.isLimited) {
      return PermissionResult.granted;
    }

    if (status.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    }

    // Request the permission
    status = await Permission.photosAddOnly.request();

    if (status.isGranted || status.isLimited) {
      return PermissionResult.granted;
    }
    if (status.isPermanentlyDenied) {
      return PermissionResult.permanentlyDenied;
    }

    return PermissionResult.denied;
  }

  /// Opens the app's system settings page so the user can grant permissions.
  static Future<bool> openSettings() async {
    return await openAppSettings();
  }
}
