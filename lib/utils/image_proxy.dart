import 'package:flutter/foundation.dart';
import '../config/constants.dart';

/// Utility to proxy images through our API when running on web to avoid CORS issues.
/// On mobile platforms, returns the original URL since CORS doesn't apply.
class ImageProxy {
  ImageProxy._();

  /// Wraps an image URL with the proxy endpoint when running on web.
  static String getUrl(String originalUrl) {
    if (!kIsWeb) {
      return originalUrl;
    }

    // Encode the URL and proxy through our API
    final encodedUrl = Uri.encodeComponent(originalUrl);
    return '${AppConstants.baseUrl}/proxy/image?url=$encodedUrl';
  }
}
