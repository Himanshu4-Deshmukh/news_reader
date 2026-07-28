import 'package:dio/dio.dart';
import 'package:news_reader/core/constants/api_constants.dart';
import 'package:news_reader/core/errors/app_exception.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout:
          const Duration(seconds: ApiConstants.timeoutSeconds),
      receiveTimeout:
          const Duration(seconds: ApiConstants.timeoutSeconds),
      queryParameters: {'apiKey': ApiConstants.apiKey},
    ));

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Map<String, dynamic>> getTopHeadlines({
    String country = 'us',
    String? category,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.topHeadlines,
        queryParameters: {
          'country': country,
          if (category != null) 'category': category,
          'page': page,
          'pageSize': ApiConstants.pageSize,
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> searchArticles({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.everything,
        queryParameters: {
          'q': query,
          'page': page,
          'pageSize': ApiConstants.pageSize,
          'sortBy': 'publishedAt',
        },
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  AppException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        return ServerException(
          statusCode: statusCode,
          message: 'Server error: $statusCode',
        );
      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled');
      case DioExceptionType.unknown:
        return const NetworkException(
            message: 'An unexpected error occurred');
      default:
        return const ServerException(message: 'Unknown error');
    }
  }
}
