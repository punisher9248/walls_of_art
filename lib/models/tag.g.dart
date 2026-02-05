// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagImpl _$$TagImplFromJson(Map<String, dynamic> json) => _$TagImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  slug: json['slug'] as String,
  count: const NullableStringToIntConverter().fromJson(json['count']),
  trendingScore: const NullableStringToIntConverter().fromJson(
    json['trendingScore'],
  ),
);

Map<String, dynamic> _$$TagImplToJson(_$TagImpl instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'count': const NullableStringToIntConverter().toJson(instance.count),
  'trendingScore': const NullableStringToIntConverter().toJson(
    instance.trendingScore,
  ),
};
