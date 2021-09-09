import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  static Future<TokenModel> getCurrentToken() async {
    final jsonToken = await _fetchTokenFromCache();
    if (jsonToken == null) throw CacheException();
    return _getTokenFromJsonString(jsonToken);
  }

  static Future<void> setTokenWithNewAccessInCache(String access) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final newToken = await _getJsonTokenWithNewAccess(access);
    sharedPreferences.setString(CachedValues.token, newToken);
  }

  static Future<void> removeTokenFromCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(CachedValues.token);
  }

  static Future<String> _getJsonTokenWithNewAccess(String access) async {
    final currentToken = await getCurrentToken();
    final newToken = TokenModel(refresh: currentToken.refresh, access: access);
    return json.encode(newToken.toJson());
  }

  static Future<String?> _fetchTokenFromCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(CachedValues.token);
  }

  static TokenModel _getTokenFromJsonString(String jsonString) {
    return TokenModel.fromJson(json.decode(jsonString));
  }
}
