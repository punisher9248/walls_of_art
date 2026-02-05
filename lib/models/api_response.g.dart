// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WallpapersResponseImpl _$$WallpapersResponseImplFromJson(
  Map<String, dynamic> json,
) => _$WallpapersResponseImpl(
  wallpapers: (json['wallpapers'] as List<dynamic>)
      .map((e) => Wallpaper.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$WallpapersResponseImplToJson(
  _$WallpapersResponseImpl instance,
) => <String, dynamic>{
  'wallpapers': instance.wallpapers,
  'pagination': instance.pagination,
};

_$TagsResponseImpl _$$TagsResponseImplFromJson(Map<String, dynamic> json) =>
    _$TagsResponseImpl(
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TagsResponseImplToJson(_$TagsResponseImpl instance) =>
    <String, dynamic>{'tags': instance.tags};

_$ApiErrorImpl _$$ApiErrorImplFromJson(Map<String, dynamic> json) =>
    _$ApiErrorImpl(
      message: json['message'] as String,
      code: json['code'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ApiErrorImplToJson(_$ApiErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'statusCode': instance.statusCode,
    };
