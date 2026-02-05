import 'package:freezed_annotation/freezed_annotation.dart';

/// Converter to handle int fields that may come as strings from the API
class StringToIntConverter implements JsonConverter<int, dynamic> {
  const StringToIntConverter();

  @override
  int fromJson(dynamic json) {
    if (json is int) return json;
    if (json is String) return int.parse(json);
    if (json is double) return json.toInt();
    throw ArgumentError('Cannot convert $json to int');
  }

  @override
  dynamic toJson(int object) => object;
}

/// Converter for nullable int fields that may come as strings
class NullableStringToIntConverter implements JsonConverter<int?, dynamic> {
  const NullableStringToIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is String) return int.tryParse(json);
    if (json is double) return json.toInt();
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}
