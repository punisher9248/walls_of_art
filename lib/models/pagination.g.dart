// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      page: const StringToIntConverter().fromJson(json['page']),
      limit: const StringToIntConverter().fromJson(json['limit']),
      total: const StringToIntConverter().fromJson(json['total']),
      totalPages: const StringToIntConverter().fromJson(json['totalPages']),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'page': const StringToIntConverter().toJson(instance.page),
      'limit': const StringToIntConverter().toJson(instance.limit),
      'total': const StringToIntConverter().toJson(instance.total),
      'totalPages': const StringToIntConverter().toJson(instance.totalPages),
    };
