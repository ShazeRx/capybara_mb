import 'package:capybara_app/core/helpers/http/http_helper.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentToken = await HttpHelper.getCurrentToken();
    if (currentToken != null) {
      options.headers['Authorization'] = 'Bearer ${currentToken.access}';
    }
    super.onRequest(options, handler);
  }
}
