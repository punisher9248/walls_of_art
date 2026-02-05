// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WallpapersResponse _$WallpapersResponseFromJson(Map<String, dynamic> json) {
  return _WallpapersResponse.fromJson(json);
}

/// @nodoc
mixin _$WallpapersResponse {
  List<Wallpaper> get wallpapers => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;

  /// Serializes this WallpapersResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallpapersResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallpapersResponseCopyWith<WallpapersResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallpapersResponseCopyWith<$Res> {
  factory $WallpapersResponseCopyWith(
    WallpapersResponse value,
    $Res Function(WallpapersResponse) then,
  ) = _$WallpapersResponseCopyWithImpl<$Res, WallpapersResponse>;
  @useResult
  $Res call({List<Wallpaper> wallpapers, Pagination pagination});

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$WallpapersResponseCopyWithImpl<$Res, $Val extends WallpapersResponse>
    implements $WallpapersResponseCopyWith<$Res> {
  _$WallpapersResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallpapersResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? wallpapers = null, Object? pagination = null}) {
    return _then(
      _value.copyWith(
            wallpapers: null == wallpapers
                ? _value.wallpapers
                : wallpapers // ignore: cast_nullable_to_non_nullable
                      as List<Wallpaper>,
            pagination: null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                      as Pagination,
          )
          as $Val,
    );
  }

  /// Create a copy of WallpapersResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WallpapersResponseImplCopyWith<$Res>
    implements $WallpapersResponseCopyWith<$Res> {
  factory _$$WallpapersResponseImplCopyWith(
    _$WallpapersResponseImpl value,
    $Res Function(_$WallpapersResponseImpl) then,
  ) = __$$WallpapersResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Wallpaper> wallpapers, Pagination pagination});

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$WallpapersResponseImplCopyWithImpl<$Res>
    extends _$WallpapersResponseCopyWithImpl<$Res, _$WallpapersResponseImpl>
    implements _$$WallpapersResponseImplCopyWith<$Res> {
  __$$WallpapersResponseImplCopyWithImpl(
    _$WallpapersResponseImpl _value,
    $Res Function(_$WallpapersResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallpapersResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? wallpapers = null, Object? pagination = null}) {
    return _then(
      _$WallpapersResponseImpl(
        wallpapers: null == wallpapers
            ? _value._wallpapers
            : wallpapers // ignore: cast_nullable_to_non_nullable
                  as List<Wallpaper>,
        pagination: null == pagination
            ? _value.pagination
            : pagination // ignore: cast_nullable_to_non_nullable
                  as Pagination,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallpapersResponseImpl implements _WallpapersResponse {
  const _$WallpapersResponseImpl({
    required final List<Wallpaper> wallpapers,
    required this.pagination,
  }) : _wallpapers = wallpapers;

  factory _$WallpapersResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallpapersResponseImplFromJson(json);

  final List<Wallpaper> _wallpapers;
  @override
  List<Wallpaper> get wallpapers {
    if (_wallpapers is EqualUnmodifiableListView) return _wallpapers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_wallpapers);
  }

  @override
  final Pagination pagination;

  @override
  String toString() {
    return 'WallpapersResponse(wallpapers: $wallpapers, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallpapersResponseImpl &&
            const DeepCollectionEquality().equals(
              other._wallpapers,
              _wallpapers,
            ) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_wallpapers),
    pagination,
  );

  /// Create a copy of WallpapersResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallpapersResponseImplCopyWith<_$WallpapersResponseImpl> get copyWith =>
      __$$WallpapersResponseImplCopyWithImpl<_$WallpapersResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WallpapersResponseImplToJson(this);
  }
}

abstract class _WallpapersResponse implements WallpapersResponse {
  const factory _WallpapersResponse({
    required final List<Wallpaper> wallpapers,
    required final Pagination pagination,
  }) = _$WallpapersResponseImpl;

  factory _WallpapersResponse.fromJson(Map<String, dynamic> json) =
      _$WallpapersResponseImpl.fromJson;

  @override
  List<Wallpaper> get wallpapers;
  @override
  Pagination get pagination;

  /// Create a copy of WallpapersResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallpapersResponseImplCopyWith<_$WallpapersResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TagsResponse _$TagsResponseFromJson(Map<String, dynamic> json) {
  return _TagsResponse.fromJson(json);
}

/// @nodoc
mixin _$TagsResponse {
  List<Tag> get tags => throw _privateConstructorUsedError;

  /// Serializes this TagsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TagsResponseCopyWith<TagsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagsResponseCopyWith<$Res> {
  factory $TagsResponseCopyWith(
    TagsResponse value,
    $Res Function(TagsResponse) then,
  ) = _$TagsResponseCopyWithImpl<$Res, TagsResponse>;
  @useResult
  $Res call({List<Tag> tags});
}

/// @nodoc
class _$TagsResponseCopyWithImpl<$Res, $Val extends TagsResponse>
    implements $TagsResponseCopyWith<$Res> {
  _$TagsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tags = null}) {
    return _then(
      _value.copyWith(
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<Tag>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TagsResponseImplCopyWith<$Res>
    implements $TagsResponseCopyWith<$Res> {
  factory _$$TagsResponseImplCopyWith(
    _$TagsResponseImpl value,
    $Res Function(_$TagsResponseImpl) then,
  ) = __$$TagsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Tag> tags});
}

/// @nodoc
class __$$TagsResponseImplCopyWithImpl<$Res>
    extends _$TagsResponseCopyWithImpl<$Res, _$TagsResponseImpl>
    implements _$$TagsResponseImplCopyWith<$Res> {
  __$$TagsResponseImplCopyWithImpl(
    _$TagsResponseImpl _value,
    $Res Function(_$TagsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tags = null}) {
    return _then(
      _$TagsResponseImpl(
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<Tag>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TagsResponseImpl implements _TagsResponse {
  const _$TagsResponseImpl({required final List<Tag> tags}) : _tags = tags;

  factory _$TagsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TagsResponseImplFromJson(json);

  final List<Tag> _tags;
  @override
  List<Tag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'TagsResponse(tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagsResponseImpl &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tags));

  /// Create a copy of TagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TagsResponseImplCopyWith<_$TagsResponseImpl> get copyWith =>
      __$$TagsResponseImplCopyWithImpl<_$TagsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TagsResponseImplToJson(this);
  }
}

abstract class _TagsResponse implements TagsResponse {
  const factory _TagsResponse({required final List<Tag> tags}) =
      _$TagsResponseImpl;

  factory _TagsResponse.fromJson(Map<String, dynamic> json) =
      _$TagsResponseImpl.fromJson;

  @override
  List<Tag> get tags;

  /// Create a copy of TagsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TagsResponseImplCopyWith<_$TagsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return _ApiError.fromJson(json);
}

/// @nodoc
mixin _$ApiError {
  String get message => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;

  /// Serializes this ApiError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiErrorCopyWith<ApiError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiErrorCopyWith<$Res> {
  factory $ApiErrorCopyWith(ApiError value, $Res Function(ApiError) then) =
      _$ApiErrorCopyWithImpl<$Res, ApiError>;
  @useResult
  $Res call({String message, String? code, int? statusCode});
}

/// @nodoc
class _$ApiErrorCopyWithImpl<$Res, $Val extends ApiError>
    implements $ApiErrorCopyWith<$Res> {
  _$ApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusCode: freezed == statusCode
                ? _value.statusCode
                : statusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiErrorImplCopyWith<$Res>
    implements $ApiErrorCopyWith<$Res> {
  factory _$$ApiErrorImplCopyWith(
    _$ApiErrorImpl value,
    $Res Function(_$ApiErrorImpl) then,
  ) = __$$ApiErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code, int? statusCode});
}

/// @nodoc
class __$$ApiErrorImplCopyWithImpl<$Res>
    extends _$ApiErrorCopyWithImpl<$Res, _$ApiErrorImpl>
    implements _$$ApiErrorImplCopyWith<$Res> {
  __$$ApiErrorImplCopyWithImpl(
    _$ApiErrorImpl _value,
    $Res Function(_$ApiErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? code = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(
      _$ApiErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApiErrorImpl implements _ApiError {
  const _$ApiErrorImpl({required this.message, this.code, this.statusCode});

  factory _$ApiErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApiErrorImplFromJson(json);

  @override
  final String message;
  @override
  final String? code;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'ApiError(message: $message, code: $code, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, code, statusCode);

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      __$$ApiErrorImplCopyWithImpl<_$ApiErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApiErrorImplToJson(this);
  }
}

abstract class _ApiError implements ApiError {
  const factory _ApiError({
    required final String message,
    final String? code,
    final int? statusCode,
  }) = _$ApiErrorImpl;

  factory _ApiError.fromJson(Map<String, dynamic> json) =
      _$ApiErrorImpl.fromJson;

  @override
  String get message;
  @override
  String? get code;
  @override
  int? get statusCode;

  /// Create a copy of ApiError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiErrorImplCopyWith<_$ApiErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
