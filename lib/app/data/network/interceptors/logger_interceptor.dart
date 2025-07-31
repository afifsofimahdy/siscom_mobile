import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
    logger.i('Headers:');
    options.headers.forEach((key, value) {
      logger.i('$key: $value');
    });
    logger.i('QueryParameters:');
    options.queryParameters.forEach((key, value) {
      logger.i('$key: $value');
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    logger.i('Response Data:');
    logger.i(response.data.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    logger.e('Error Message:');
    logger.e(err.message);
    super.onError(err, handler);
  }
}