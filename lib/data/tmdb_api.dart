import 'package:dio/dio.dart';
import '../core/env.dart';
import '../core/failure.dart';

class TmdbApi {
  final Dio _dio;

  TmdbApi([Dio? dio]) : _dio = dio ?? Dio(BaseOptions(baseUrl: Env.tmdbBase));

  Map<String, dynamic> _authParams([Map<String, dynamic>? extra]) =>
      {'api_key': Env.tmdbKey, ...?extra};

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final res = await _dio.get(path, queryParameters: _authParams(query));
      return res;
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final msg = e.response?.data is Map ? (e.response!.data['status_message'] ?? e.message) : e.message;
      throw Failure(msg ?? 'Network error', statusCode: code);
    }
  }
}
