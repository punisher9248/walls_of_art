import 'package:dio/dio.dart';
import '../config/constants.dart';
import '../models/models.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;

  ApiException({
    required this.message,
    this.statusCode,
    this.code,
  });

  factory ApiException.fromDioError(DioException error) {
    String message;
    int? statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badResponse:
        statusCode = error.response?.statusCode;
        final data = error.response?.data;
        if (data is Map<String, dynamic> && data.containsKey('message')) {
          message = data['message'] as String;
        } else {
          message = 'Server error. Please try again later.';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      default:
        message = 'Something went wrong. Please try again.';
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
    );
  }

  @override
  String toString() => message;
}

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor for debug builds
    assert(() {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      );
      return true;
    }());
  }

  Future<WallpapersResponse> getWallpapers({
    int page = 1,
    int limit = 50,
    String? tag,
    String sort = 'newest',
  }) async {
    try {
      final response = await _dio.get(
        '/wallpapers',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (tag != null && tag.isNotEmpty) 'tag': tag,
          'sort': sort,
        },
      );

      return WallpapersResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: 'Failed to parse response: $e');
    }
  }

  Future<List<Tag>> getTags() async {
    try {
      final response = await _dio.get('/tags');
      final data = response.data as Map<String, dynamic>;
      final tagsJson = data['tags'] as List;
      return tagsJson
          .map((t) => Tag.fromJson(t as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: 'Failed to parse tags: $e');
    }
  }

  Future<Wallpaper?> getWallpaperById(String id) async {
    try {
      // Try to get single wallpaper from the wallpapers list
      // Since there's no dedicated endpoint, we fetch a page and find it
      final response = await getWallpapers(page: 1, limit: 100);
      return response.wallpapers.firstWhere(
        (w) => w.id == id,
        orElse: () => throw ApiException(message: 'Wallpaper not found'),
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: 'Failed to get wallpaper: $e');
    }
  }

  void dispose() {
    _dio.close();
  }
}
