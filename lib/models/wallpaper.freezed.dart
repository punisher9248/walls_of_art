// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallpaper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Wallpaper _$WallpaperFromJson(Map<String, dynamic> json) {
  return _Wallpaper.fromJson(json);
}

/// @nodoc
mixin _$Wallpaper {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  String get previewUrl => throw _privateConstructorUsedError;
  String get downloadUrl => throw _privateConstructorUsedError;
  @StringToIntConverter()
  int get width => throw _privateConstructorUsedError;
  @StringToIntConverter()
  int get height => throw _privateConstructorUsedError;
  String? get resolution => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get sourceId => throw _privateConstructorUsedError;
  String? get sourceUrl => throw _privateConstructorUsedError;
  String? get subreddit => throw _privateConstructorUsedError;
  String? get colors => throw _privateConstructorUsedError;
  @NullableStringToIntConverter()
  int? get upvotes => throw _privateConstructorUsedError;
  @NullableStringToIntConverter()
  int? get downloads => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get scrapedAt => throw _privateConstructorUsedError;
  List<WallpaperTag> get tags => throw _privateConstructorUsedError;

  /// Serializes this Wallpaper to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallpaperCopyWith<Wallpaper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallpaperCopyWith<$Res> {
  factory $WallpaperCopyWith(Wallpaper value, $Res Function(Wallpaper) then) =
      _$WallpaperCopyWithImpl<$Res, Wallpaper>;
  @useResult
  $Res call({
    String id,
    String title,
    String slug,
    String thumbnailUrl,
    String previewUrl,
    String downloadUrl,
    @StringToIntConverter() int width,
    @StringToIntConverter() int height,
    String? resolution,
    String source,
    String sourceId,
    String? sourceUrl,
    String? subreddit,
    String? colors,
    @NullableStringToIntConverter() int? upvotes,
    @NullableStringToIntConverter() int? downloads,
    DateTime createdAt,
    DateTime scrapedAt,
    List<WallpaperTag> tags,
  });
}

/// @nodoc
class _$WallpaperCopyWithImpl<$Res, $Val extends Wallpaper>
    implements $WallpaperCopyWith<$Res> {
  _$WallpaperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = null,
    Object? thumbnailUrl = null,
    Object? previewUrl = null,
    Object? downloadUrl = null,
    Object? width = null,
    Object? height = null,
    Object? resolution = freezed,
    Object? source = null,
    Object? sourceId = null,
    Object? sourceUrl = freezed,
    Object? subreddit = freezed,
    Object? colors = freezed,
    Object? upvotes = freezed,
    Object? downloads = freezed,
    Object? createdAt = null,
    Object? scrapedAt = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: null == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            previewUrl: null == previewUrl
                ? _value.previewUrl
                : previewUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            downloadUrl: null == downloadUrl
                ? _value.downloadUrl
                : downloadUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int,
            resolution: freezed == resolution
                ? _value.resolution
                : resolution // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceId: null == sourceId
                ? _value.sourceId
                : sourceId // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceUrl: freezed == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            subreddit: freezed == subreddit
                ? _value.subreddit
                : subreddit // ignore: cast_nullable_to_non_nullable
                      as String?,
            colors: freezed == colors
                ? _value.colors
                : colors // ignore: cast_nullable_to_non_nullable
                      as String?,
            upvotes: freezed == upvotes
                ? _value.upvotes
                : upvotes // ignore: cast_nullable_to_non_nullable
                      as int?,
            downloads: freezed == downloads
                ? _value.downloads
                : downloads // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            scrapedAt: null == scrapedAt
                ? _value.scrapedAt
                : scrapedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<WallpaperTag>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallpaperImplCopyWith<$Res>
    implements $WallpaperCopyWith<$Res> {
  factory _$$WallpaperImplCopyWith(
    _$WallpaperImpl value,
    $Res Function(_$WallpaperImpl) then,
  ) = __$$WallpaperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String slug,
    String thumbnailUrl,
    String previewUrl,
    String downloadUrl,
    @StringToIntConverter() int width,
    @StringToIntConverter() int height,
    String? resolution,
    String source,
    String sourceId,
    String? sourceUrl,
    String? subreddit,
    String? colors,
    @NullableStringToIntConverter() int? upvotes,
    @NullableStringToIntConverter() int? downloads,
    DateTime createdAt,
    DateTime scrapedAt,
    List<WallpaperTag> tags,
  });
}

/// @nodoc
class __$$WallpaperImplCopyWithImpl<$Res>
    extends _$WallpaperCopyWithImpl<$Res, _$WallpaperImpl>
    implements _$$WallpaperImplCopyWith<$Res> {
  __$$WallpaperImplCopyWithImpl(
    _$WallpaperImpl _value,
    $Res Function(_$WallpaperImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = null,
    Object? thumbnailUrl = null,
    Object? previewUrl = null,
    Object? downloadUrl = null,
    Object? width = null,
    Object? height = null,
    Object? resolution = freezed,
    Object? source = null,
    Object? sourceId = null,
    Object? sourceUrl = freezed,
    Object? subreddit = freezed,
    Object? colors = freezed,
    Object? upvotes = freezed,
    Object? downloads = freezed,
    Object? createdAt = null,
    Object? scrapedAt = null,
    Object? tags = null,
  }) {
    return _then(
      _$WallpaperImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: null == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        previewUrl: null == previewUrl
            ? _value.previewUrl
            : previewUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        downloadUrl: null == downloadUrl
            ? _value.downloadUrl
            : downloadUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int,
        resolution: freezed == resolution
            ? _value.resolution
            : resolution // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceId: null == sourceId
            ? _value.sourceId
            : sourceId // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceUrl: freezed == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        subreddit: freezed == subreddit
            ? _value.subreddit
            : subreddit // ignore: cast_nullable_to_non_nullable
                  as String?,
        colors: freezed == colors
            ? _value.colors
            : colors // ignore: cast_nullable_to_non_nullable
                  as String?,
        upvotes: freezed == upvotes
            ? _value.upvotes
            : upvotes // ignore: cast_nullable_to_non_nullable
                  as int?,
        downloads: freezed == downloads
            ? _value.downloads
            : downloads // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        scrapedAt: null == scrapedAt
            ? _value.scrapedAt
            : scrapedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<WallpaperTag>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallpaperImpl extends _Wallpaper {
  const _$WallpaperImpl({
    required this.id,
    required this.title,
    required this.slug,
    required this.thumbnailUrl,
    required this.previewUrl,
    required this.downloadUrl,
    @StringToIntConverter() required this.width,
    @StringToIntConverter() required this.height,
    this.resolution,
    required this.source,
    required this.sourceId,
    this.sourceUrl,
    this.subreddit,
    this.colors,
    @NullableStringToIntConverter() this.upvotes,
    @NullableStringToIntConverter() this.downloads,
    required this.createdAt,
    required this.scrapedAt,
    final List<WallpaperTag> tags = const [],
  }) : _tags = tags,
       super._();

  factory _$WallpaperImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallpaperImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String slug;
  @override
  final String thumbnailUrl;
  @override
  final String previewUrl;
  @override
  final String downloadUrl;
  @override
  @StringToIntConverter()
  final int width;
  @override
  @StringToIntConverter()
  final int height;
  @override
  final String? resolution;
  @override
  final String source;
  @override
  final String sourceId;
  @override
  final String? sourceUrl;
  @override
  final String? subreddit;
  @override
  final String? colors;
  @override
  @NullableStringToIntConverter()
  final int? upvotes;
  @override
  @NullableStringToIntConverter()
  final int? downloads;
  @override
  final DateTime createdAt;
  @override
  final DateTime scrapedAt;
  final List<WallpaperTag> _tags;
  @override
  @JsonKey()
  List<WallpaperTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Wallpaper(id: $id, title: $title, slug: $slug, thumbnailUrl: $thumbnailUrl, previewUrl: $previewUrl, downloadUrl: $downloadUrl, width: $width, height: $height, resolution: $resolution, source: $source, sourceId: $sourceId, sourceUrl: $sourceUrl, subreddit: $subreddit, colors: $colors, upvotes: $upvotes, downloads: $downloads, createdAt: $createdAt, scrapedAt: $scrapedAt, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallpaperImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.previewUrl, previewUrl) ||
                other.previewUrl == previewUrl) &&
            (identical(other.downloadUrl, downloadUrl) ||
                other.downloadUrl == downloadUrl) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.subreddit, subreddit) ||
                other.subreddit == subreddit) &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.upvotes, upvotes) || other.upvotes == upvotes) &&
            (identical(other.downloads, downloads) ||
                other.downloads == downloads) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.scrapedAt, scrapedAt) ||
                other.scrapedAt == scrapedAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    slug,
    thumbnailUrl,
    previewUrl,
    downloadUrl,
    width,
    height,
    resolution,
    source,
    sourceId,
    sourceUrl,
    subreddit,
    colors,
    upvotes,
    downloads,
    createdAt,
    scrapedAt,
    const DeepCollectionEquality().hash(_tags),
  ]);

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallpaperImplCopyWith<_$WallpaperImpl> get copyWith =>
      __$$WallpaperImplCopyWithImpl<_$WallpaperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallpaperImplToJson(this);
  }
}

abstract class _Wallpaper extends Wallpaper {
  const factory _Wallpaper({
    required final String id,
    required final String title,
    required final String slug,
    required final String thumbnailUrl,
    required final String previewUrl,
    required final String downloadUrl,
    @StringToIntConverter() required final int width,
    @StringToIntConverter() required final int height,
    final String? resolution,
    required final String source,
    required final String sourceId,
    final String? sourceUrl,
    final String? subreddit,
    final String? colors,
    @NullableStringToIntConverter() final int? upvotes,
    @NullableStringToIntConverter() final int? downloads,
    required final DateTime createdAt,
    required final DateTime scrapedAt,
    final List<WallpaperTag> tags,
  }) = _$WallpaperImpl;
  const _Wallpaper._() : super._();

  factory _Wallpaper.fromJson(Map<String, dynamic> json) =
      _$WallpaperImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get slug;
  @override
  String get thumbnailUrl;
  @override
  String get previewUrl;
  @override
  String get downloadUrl;
  @override
  @StringToIntConverter()
  int get width;
  @override
  @StringToIntConverter()
  int get height;
  @override
  String? get resolution;
  @override
  String get source;
  @override
  String get sourceId;
  @override
  String? get sourceUrl;
  @override
  String? get subreddit;
  @override
  String? get colors;
  @override
  @NullableStringToIntConverter()
  int? get upvotes;
  @override
  @NullableStringToIntConverter()
  int? get downloads;
  @override
  DateTime get createdAt;
  @override
  DateTime get scrapedAt;
  @override
  List<WallpaperTag> get tags;

  /// Create a copy of Wallpaper
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallpaperImplCopyWith<_$WallpaperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WallpaperTag _$WallpaperTagFromJson(Map<String, dynamic> json) {
  return _WallpaperTag.fromJson(json);
}

/// @nodoc
mixin _$WallpaperTag {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;

  /// Serializes this WallpaperTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WallpaperTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WallpaperTagCopyWith<WallpaperTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WallpaperTagCopyWith<$Res> {
  factory $WallpaperTagCopyWith(
    WallpaperTag value,
    $Res Function(WallpaperTag) then,
  ) = _$WallpaperTagCopyWithImpl<$Res, WallpaperTag>;
  @useResult
  $Res call({String id, String name, String slug});
}

/// @nodoc
class _$WallpaperTagCopyWithImpl<$Res, $Val extends WallpaperTag>
    implements $WallpaperTagCopyWith<$Res> {
  _$WallpaperTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WallpaperTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? slug = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WallpaperTagImplCopyWith<$Res>
    implements $WallpaperTagCopyWith<$Res> {
  factory _$$WallpaperTagImplCopyWith(
    _$WallpaperTagImpl value,
    $Res Function(_$WallpaperTagImpl) then,
  ) = __$$WallpaperTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String slug});
}

/// @nodoc
class __$$WallpaperTagImplCopyWithImpl<$Res>
    extends _$WallpaperTagCopyWithImpl<$Res, _$WallpaperTagImpl>
    implements _$$WallpaperTagImplCopyWith<$Res> {
  __$$WallpaperTagImplCopyWithImpl(
    _$WallpaperTagImpl _value,
    $Res Function(_$WallpaperTagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WallpaperTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? slug = null}) {
    return _then(
      _$WallpaperTagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WallpaperTagImpl implements _WallpaperTag {
  const _$WallpaperTagImpl({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory _$WallpaperTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$WallpaperTagImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String slug;

  @override
  String toString() {
    return 'WallpaperTag(id: $id, name: $name, slug: $slug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WallpaperTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  /// Create a copy of WallpaperTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WallpaperTagImplCopyWith<_$WallpaperTagImpl> get copyWith =>
      __$$WallpaperTagImplCopyWithImpl<_$WallpaperTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WallpaperTagImplToJson(this);
  }
}

abstract class _WallpaperTag implements WallpaperTag {
  const factory _WallpaperTag({
    required final String id,
    required final String name,
    required final String slug,
  }) = _$WallpaperTagImpl;

  factory _WallpaperTag.fromJson(Map<String, dynamic> json) =
      _$WallpaperTagImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get slug;

  /// Create a copy of WallpaperTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WallpaperTagImplCopyWith<_$WallpaperTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
