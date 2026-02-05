import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../config/constants.dart';

class CacheService {
  late final CacheManager _thumbnailCache;
  late final CacheManager _fullImageCache;

  CacheService() {
    _thumbnailCache = CacheManager(
      Config(
        AppConstants.thumbnailCacheKey,
        stalePeriod: Duration(days: AppConstants.thumbnailMaxAgeDays),
        maxNrOfCacheObjects: AppConstants.thumbnailMaxItems,
      ),
    );

    _fullImageCache = CacheManager(
      Config(
        AppConstants.fullImageCacheKey,
        stalePeriod: Duration(days: AppConstants.fullImageMaxAgeDays),
        maxNrOfCacheObjects: AppConstants.fullImageMaxItems,
      ),
    );
  }

  CacheManager get thumbnailCache => _thumbnailCache;
  CacheManager get fullImageCache => _fullImageCache;

  /// Cache full image for offline favorites
  Future<void> cacheFullImage(String url) async {
    try {
      await _fullImageCache.downloadFile(url);
    } catch (e) {
      // Silently fail - caching is best effort
    }
  }

  /// Remove image from cache when unfavorited
  Future<void> removeFromCache(String url) async {
    try {
      await _fullImageCache.removeFile(url);
    } catch (e) {
      // Silently fail
    }
  }

  /// Check if image is cached
  Future<bool> isImageCached(String url) async {
    try {
      final fileInfo = await _fullImageCache.getFileFromCache(url);
      return fileInfo != null;
    } catch (e) {
      return false;
    }
  }

  /// Get cache size in bytes
  Future<int> getCacheSize() async {
    // Note: flutter_cache_manager doesn't provide direct size access
    // This is a placeholder - actual implementation would need to
    // iterate through cache directory
    return 0;
  }

  /// Clear all caches
  Future<void> clearAll() async {
    await _thumbnailCache.emptyCache();
    await _fullImageCache.emptyCache();
  }

  /// Clear thumbnail cache only
  Future<void> clearThumbnails() async {
    await _thumbnailCache.emptyCache();
  }

  /// Clear full image cache only
  Future<void> clearFullImages() async {
    await _fullImageCache.emptyCache();
  }

  void dispose() {
    _thumbnailCache.dispose();
    _fullImageCache.dispose();
  }
}
