import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';
import 'package:flutter_weather_app/network/api/application_dio.dart';
import 'package:flutter_weather_app/network/api/rest_client.dart';
import 'package:logger/logger.dart';

import 'api_response.dart';

class BaseRepository {
  BaseRepository() {
    _restClient = RestClient(_dio);
  }

  final Dio _dio = AppHttpClient().dio;
  RestClient _restClient;

  RestClient get restClient {
    return _restClient;
  }

  Future<ApiResponse<T>> handleException<T>(
      Object exception, StackTrace stackTrace) async {
    if (exception is DioError) {
      final ApiError error = _handleDioException(exception, stackTrace);
      return ApiResponse<T>.error(
          message: error.message, statusCode: error.code);
    } else if (exception is Exception) {
      final ApiError error = _handleException(exception, stackTrace);
      return ApiResponse<T>.error(
          message: error.message, statusCode: error.code);
    } else {
      return ApiResponse<T>.error(message: Strings.unknownError);
    }
  }

  ApiError _handleDioException(DioError e, StackTrace stackTrace) {
    if (e.type == DioErrorType.RESPONSE) {
      final int statusCode = e.response.statusCode;
      if (statusCode == HttpStatus.unauthorized) {
        return ApiError(code: statusCode, message: Strings.unauthorized);
      } else {
        Logger().e(Strings.error, e, stackTrace);
        return ApiError(code: statusCode, message: e.response.statusMessage);
      }
    } else {
      Logger().e(Strings.error, e, stackTrace);
      return ApiError(message: e.message);
    }
  }

  ApiError _handleException(Exception e, StackTrace stackTrace) {
    Logger().e(Strings.error, e, stackTrace);
    return ApiError(code: null, message: e.toString());
  }
}

class ApiError {
  ApiError({this.code, this.message});

  String message;
  int code;
}