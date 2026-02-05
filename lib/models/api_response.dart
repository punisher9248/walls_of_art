import 'package:freezed_annotation/freezed_annotation.dart';
import 'wallpaper.dart';
import 'tag.dart';
import 'pagination.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
class WallpapersResponse with _$WallpapersResponse {
  const factory WallpapersResponse({
    required List<Wallpaper> wallpapers,
    required Pagination pagination,
  }) = _WallpapersResponse;

  factory WallpapersResponse.fromJson(Map<String, dynamic> json) =>
      _$WallpapersResponseFromJson(json);
}

@freezed
class TagsResponse with _$TagsResponse {
  const factory TagsResponse({
    required List<Tag> tags,
  }) = _TagsResponse;

  factory TagsResponse.fromJson(Map<String, dynamic> json) =>
      _$TagsResponseFromJson(json);
}

@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    required String message,
    String? code,
    int? statusCode,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}
