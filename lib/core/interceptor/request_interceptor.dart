import 'package:dio/dio.dart';
import 'package:nuze_app/core/constant.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Accept': 'application/json'});
    print('Request => ${options.uri}');

    if (options.uri.host.contains("gnews.io")) {
      options.queryParameters["token"] = ApiConstant.GNewsApi;
    } else if (options.uri.host.contains("newsapi.org")) {
      options.queryParameters["apiKey"] = ApiConstant.NewsApiKey;
    }

    handler.next(options); // ← always called, outside the if/else
  }
}
