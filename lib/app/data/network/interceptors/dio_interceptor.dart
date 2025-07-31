// ignore_for_file: unnecessary_overrides

import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add common headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    
    // Add token if exists
    // final token = GetStorage().read('token');
    // if (token != null) {
    //   options.headers['Authorization'] = 'Bearer $token';
    // }
    
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}