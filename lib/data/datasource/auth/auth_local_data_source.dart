import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';

import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  /// Gets the cached [TokenModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<TokenModel> fetchToken();

  Future<void> cacheToken(TokenModel token);

  Future<Unit> removeToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
  }) : this._sharedPreferences = sharedPreferences;

  @override
  Future<TokenModel> fetchToken() {
    final jsonString = this._sharedPreferences.getString(CachedValues.token);

    if (jsonString == null) throw CacheException();

    // Future which is immediately completed
    return Future.value(
      TokenModel.fromJson(json.decode(jsonString)),
    );
  }

  @override
  Future<void> cacheToken(TokenModel token) {
    return this._sharedPreferences.setString(
          CachedValues.token,
          json.encode(token.toJson()),
        );
  }

  @override
  Future<Unit> removeToken() {
    final jsonString = this._sharedPreferences.getString(CachedValues.token);

    if (jsonString == null) throw CacheException();

    this._sharedPreferences.remove(CachedValues.token);

    return Future.value(unit);
  }
}
