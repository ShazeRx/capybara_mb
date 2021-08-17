import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';

import 'package:capybara_app/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  /// Gets the cached [TokenModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TokenModel> fetchToken();

  Future<void> cacheToken(TokenModel token);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<TokenModel> fetchToken() {
    final jsonString = this.sharedPreferences.getString(CachedValues.token);

    if (jsonString == null) throw CacheException();

    // Future which is immediately completed
    return Future.value(
      TokenModel.fromJson(json.decode(jsonString)),
    );
  }

  @override
  Future<void> cacheToken(TokenModel token) {
    return this.sharedPreferences.setString(
          CachedValues.token,
          json.encode(token.toJson()),
        );
  }
}
