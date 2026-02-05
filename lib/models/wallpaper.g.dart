// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallpaper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallpaperImpl _$$WallpaperImplFromJson(Map<String, dynamic> json) =>
    _$WallpaperImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      previewUrl: json['previewUrl'] as String,
      downloadUrl: json['downloadUrl'] as String,
      width: const StringToIntConverter().fromJson(json['width']),
      height: const StringToIntConverter().fromJson(json['height']),
      resolution: json['resolution'] as String?,
      source: json['source'] as String,
      sourceId: json['sourceId'] as String,
      sourceUrl: json['sourceUrl'] as String?,
      subreddit: json['subreddit'] as String?,
      colors: json['colors'] as String?,
      upvotes: const NullableStringToIntConverter().fromJson(json['upvotes']),
      downloads: const NullableStringToIntConverter().fromJson(
        json['downloads'],
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      scrapedAt: DateTime.parse(json['scrapedAt'] as String),
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => WallpaperTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WallpaperImplToJson(
  _$WallpaperImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'thumbnailUrl': instance.thumbnailUrl,
  'previewUrl': instance.previewUrl,
  'downloadUrl': instance.downloadUrl,
  'width': const StringToIntConverter().toJson(instance.width),
  'height': const StringToIntConverter().toJson(instance.height),
  'resolution': instance.resolution,
  'source': instance.source,
  'sourceId': instance.sourceId,
  'sourceUrl': instance.sourceUrl,
  'subreddit': instance.subreddit,
  'colors': instance.colors,
  'upvotes': const NullableStringToIntConverter().toJson(instance.upvotes),
  'downloads': const NullableStringToIntConverter().toJson(instance.downloads),
  'createdAt': instance.createdAt.toIso8601String(),
  'scrapedAt': instance.scrapedAt.toIso8601String(),
  'tags': instance.tags,
};

_$WallpaperTagImpl _$$WallpaperTagImplFromJson(Map<String, dynamic> json) =>
    _$WallpaperTagImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$$WallpaperTagImplToJson(_$WallpaperTagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
    };
