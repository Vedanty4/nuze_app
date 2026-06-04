import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorInteceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        print('Connection timout');
        break;

      case DioExceptionType.receiveTimeout:
        print('recive timeout');
        break;
      case DioExceptionType.badResponse:
        print('bad response => ${err.response?.statusCode}');
        break;

      default:
        print("Something went wrong");
    }
    handler.next(err);
  }
}
