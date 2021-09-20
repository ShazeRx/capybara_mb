import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/protocols/token_utilites.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final TokenUtilities _interceptorUtilities = getIt<TokenUtilities>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final currentUrl = options.path;
    final baseUrl = Api.baseUrl;
    //Variable checks if url is login or refresh to not include token in header
    final isLoginRequest = currentUrl == baseUrl + Api.loginUrl ||
        currentUrl == baseUrl + Api.refreshUrl;
    try {
      if (!isLoginRequest) {
        final currentToken = await _interceptorUtilities.getCurrentToken();
        options.headers['Authorization'] = 'Bearer ${currentToken.access}';
      }
    } on CacheException {}
    super.onRequest(options, handler);
  }
}
