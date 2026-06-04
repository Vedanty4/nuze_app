import 'package:dio/dio.dart';

import '../interceptor/error_Inteceptor.dart';
import '../interceptor/request_interceptor.dart';
import '../interceptor/response_inteceptor.dart';

class DioClient {
  static final Dio dio =
      Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.addAll([
          RequestInterceptor(),

          ResponseInterceptor(),

          ErrorInteceptor(),
        ]);
}
