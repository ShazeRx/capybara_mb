import 'dart:convert';

import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/http_methods.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/helpers/token/token_helper.dart';
import 'package:capybara_app/data/models/auth/refresh_model.dart';
import 'package:capybara_app/data/requests/auth/refresh_request.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  final Function _invoke;
  final TokenState _tokenState = getIt<TokenState>();

  ErrorInterceptor({required invoke}) : this._invoke = invoke;

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      try {
        await this._refreshToken();
        return await this._retry(error.requestOptions);
      } on CacheException {}
    }

    super.onError(error, handler);
  }

  Future<void> _refreshToken() async {
    final currentToken = await TokenHelper.getCurrentToken();
    final payload = RefreshRequest(refresh: currentToken.refresh).toJson();
    try {
      final response = await this._invoke(
        url: Api.refreshUrl,
        method: HttpMethods.post,
        body: payload,
      );
      final refreshModel = RefreshModel.fromJson(json.decode(response));
      await TokenHelper.setTokenWithNewAccessInCache(refreshModel.access);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        TokenHelper.removeTokenFromCache();
        this._tokenState.setToken(null);
      }
    }
  }

  Future<dynamic> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return await this._invoke(
      url: requestOptions.path,
      method: requestOptions.method,
      options: options,
      body: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}
