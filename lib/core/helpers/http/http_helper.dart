import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelper {
  static Future<TokenModel> getCurrentToken() async {
    final jsonToken = await _fetchTokenFromCache();
    if (jsonToken == null) throw CacheException();
    return _getTokenFromJsonString(jsonToken);
  }

  static Future<String?> _fetchTokenFromCache() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(CachedValues.token);
  }

  static TokenModel _getTokenFromJsonString(String jsonString) {
    return TokenModel.fromJson(json.decode(jsonString));
  }
}
