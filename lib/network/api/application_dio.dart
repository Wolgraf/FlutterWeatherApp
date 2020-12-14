import 'package:dio/dio.dart';
import 'package:flutter_weather_app/common/resources/constants.dart';

class AppHttpClient {
  Dio get dio => _buildDio();

  Dio _buildDio() {
    final Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.connectTimeout = TIMEOUT_MS;
    dio.options.receiveTimeout = TIMEOUT_MS;
    return dio;
  }
}
