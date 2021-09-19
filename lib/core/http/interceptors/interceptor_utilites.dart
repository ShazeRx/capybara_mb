import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class InterceptorUtilities {
  Future<TokenModel> getCurrentToken();

  Future<void> setTokenWithNewAccessInCache(String access);

  Future<void> removeTokenFromCache();
}

class InterceptorUtilitiesImpl implements InterceptorUtilities {
  final SharedPreferences _sharedPreferences;

  InterceptorUtilitiesImpl({
    required SharedPreferences sharedPreferences,
  }) : this._sharedPreferences = sharedPreferences;

  Future<TokenModel> getCurrentToken() async {
    final jsonToken = await _fetchTokenFromCache();
    if (jsonToken == null) throw CacheException();
    return _getTokenFromJsonString(jsonToken);
  }

  Future<void> setTokenWithNewAccessInCache(String access) async {
    final newToken = await _getJsonTokenWithNewAccess(access);
    this._sharedPreferences.setString(CachedValues.token, newToken);
  }

  Future<void> removeTokenFromCache() async {
    this._sharedPreferences.remove(CachedValues.token);
  }

  Future<String> _getJsonTokenWithNewAccess(String access) async {
    final currentToken = await getCurrentToken();
    final newToken = TokenModel(refresh: currentToken.refresh, access: access);
    return json.encode(newToken.toJson());
  }

  Future<String?> _fetchTokenFromCache() async {
    return this._sharedPreferences.getString(CachedValues.token);
  }

  TokenModel _getTokenFromJsonString(String jsonString) {
    return TokenModel.fromJson(json.decode(jsonString));
  }
}
