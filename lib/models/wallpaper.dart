import 'package:freezed_annotation/freezed_annotation.dart';
import 'converters.dart';

part 'wallpaper.freezed.dart';
part 'wallpaper.g.dart';

@freezed
class Wallpaper with _$Wallpaper {
  const Wallpaper._();

  const factory Wallpaper({
    required String id,
    required String title,
    required String slug,
    required String thumbnailUrl,
    required String previewUrl,
    required String downloadUrl,
    @StringToIntConverter() required int width,
    @StringToIntConverter() required int height,
    String? resolution,
    required String source,
    required String sourceId,
    String? sourceUrl,
    String? subreddit,
    String? colors,
    @NullableStringToIntConverter() int? upvotes,
    @NullableStringToIntConverter() int? downloads,
    required DateTime createdAt,
    required DateTime scrapedAt,
    @Default([]) List<WallpaperTag> tags,
  }) = _Wallpaper;

  factory Wallpaper.fromJson(Map<String, dynamic> json) =>
      _$WallpaperFromJson(json);

  // Computed properties
  String get shortId => id.toUpperCase();

  double get aspectRatio => width / height;

  String get dimensionsText => '$width × $height';

  double get megapixels => (width * height) / 1000000;

  String get megapixelsText => '${megapixels.toStringAsFixed(1)} MP';

  String get aspectRatioText {
    final gcd = _gcd(width, height);
    final w = width ~/ gcd;
    final h = height ~/ gcd;
    return '$w:$h';
  }

  static int _gcd(int a, int b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  List<String>? get colorList {
    if (colors == null) return null;
    try {
      final decoded = colors!.replaceAll(r'\"', '"');
      final list = List<String>.from(
        decoded.startsWith('[')
          ? jsonDecode(decoded)
          : decoded.split(','),
      );
      return list;
    } catch (_) {
      return null;
    }
  }
}

List<dynamic> jsonDecode(String source) {
  // Simple JSON array parser for colors
  if (!source.startsWith('[') || !source.endsWith(']')) return [];
  final content = source.substring(1, source.length - 1);
  return content
      .split(',')
      .map((s) => s.trim().replaceAll('"', ''))
      .where((s) => s.isNotEmpty)
      .toList();
}

@freezed
class WallpaperTag with _$WallpaperTag {
  const factory WallpaperTag({
    required String id,
    required String name,
    required String slug,
  }) = _WallpaperTag;

  factory WallpaperTag.fromJson(Map<String, dynamic> json) =>
      _$WallpaperTagFromJson(json);
}
