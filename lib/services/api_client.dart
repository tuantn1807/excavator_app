import 'package:dio/dio.dart';
import '../utils/constants.dart';
import '../utils/token_storage.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('📡 API Request: [${options.method}] ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '✅ API Response: [${response.statusCode}] ${response.requestOptions.uri}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print(
            '❌ API Error: [${e.response?.statusCode}] ${e.requestOptions.uri}',
          );
          print('Error details: ${e.message}');
          if (e.response?.statusCode == 401) {
            TokenStorage.clearToken();
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Common error handling wrapper
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'].toString();
      }
      if (data is Map && data.containsKey('errors')) {
        final errors = data['errors'];
        if (errors is Map) {
          return errors.values.expand((v) => v is List ? v : [v]).join('\n');
        }
        return errors.toString();
      }
      return 'Lỗi ${e.response?.statusCode}: ${e.response?.statusMessage}';
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Kết nối quá chậm, vui lòng thử lại.';
    }
    if (e.type == DioExceptionType.connectionError) {
      return 'Không thể kết nối đến máy chủ. Vui lòng kiểm tra mạng hoặc địa chỉ API.';
    }
    return 'Lỗi kết nối: ${e.message}';
  }
}
