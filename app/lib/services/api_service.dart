import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.data is Map && response.data['code'] != 200) {
          throw Exception(response.data['message'] ?? '请求失败');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        throw Exception(error.response?.data['message'] ?? error.message);
      },
    ));
  }

  Future<void> sendCode(String phone) async {
    await _dio.post('/auth/send-code', queryParameters: {'phone': phone});
  }

  Future<Map<String, dynamic>> login(String phone, String code) async {
    final response = await _dio.post('/auth/login', data: {
      'phone': phone,
      'code': code,
    });
    return response.data['data'];
  }

  Future<Map<String, dynamic>> getUser() async {
    final response = await _dio.get('/user/1');
    return response.data['data'];
  }

  Future<Map<String, dynamic>> updateUser(int userId, Map<String, dynamic> data) async {
    final response = await _dio.put('/user/$userId', data: data);
    return response.data['data'];
  }
}