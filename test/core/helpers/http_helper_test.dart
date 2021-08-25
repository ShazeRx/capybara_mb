import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/helpers/http/http_helper.dart';
import 'package:capybara_app/data/models/token_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final tToken = TokenModel(refresh: '123', access: '321');
  final tSharedPreferences = await SharedPreferences.getInstance();
  group('get current token', () {
    test('should return valid token model if there is one in cache', () async {
      // Arrange
      tSharedPreferences.setString(
          CachedValues.token, json.encode(tToken.toJson()));

      // Act
      final result = await HttpHelper.getCurrentToken();

      // Assert
      expect(result, tToken);
    });

    test('should throw a CacheException where there is not cached token', () {
      // Arrange
      tSharedPreferences.clear();

      // Act
      final call = HttpHelper.getCurrentToken;

      // Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
}
