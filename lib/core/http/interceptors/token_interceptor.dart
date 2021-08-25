import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/helpers/http/http_helper.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final currentToken = await HttpHelper.getCurrentToken();
      options.headers['Authorization'] = 'Bearer ${currentToken.access}';
    } on CacheException {}
    super.onRequest(options, handler);
  }
}
