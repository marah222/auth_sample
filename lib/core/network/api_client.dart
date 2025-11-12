import 'package:dio/dio.dart';

// This class is a wrapper around the Dio package.
// It centralizes all networking logic, making it easier to manage
// things like adding headers, handling errors, or logging in one place.
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw e;
    }
  }
}
