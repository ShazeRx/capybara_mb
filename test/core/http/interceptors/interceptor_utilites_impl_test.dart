import 'dart:convert';
import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/http/interceptors/interceptor_utilites.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() async {
  late MockSharedPreferences mockSharedPreferences;
  late InterceptorUtilities interceptorUtilities;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    interceptorUtilities = InterceptorUtilitiesImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tToken = TokenModel(refresh: '123', access: '321');
  group('get current token', () {
    test('should return valid token model if there is one in cache', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(CachedValues.token))
          .thenReturn(fixture(FixturePaths.tokenJson));

      // Act
      final result = await interceptorUtilities.getCurrentToken();

      // Assert
      expect(result, tToken);
    });

    test('should throw a CacheException where there is not cached token', () {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      // Act
      final call = interceptorUtilities.getCurrentToken;

      // Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('remove token from cache', () {
    test('should remove token from cache', () async {
      // Arrange
      when(() => mockSharedPreferences.remove(CachedValues.token))
          .thenAnswer((_) async => true);

      // Act
      await interceptorUtilities.removeTokenFromCache();

      // Assert
      verify(() => mockSharedPreferences.remove(CachedValues.token));
    });
  });

  group('set token with new access in cache', () {
    test('should set token with new access in cache ', () async {
      // Arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.getString(CachedValues.token))
          .thenReturn(json.encode(tToken.toJson()));

      final access = '999';
      final newToken = TokenModel(refresh: tToken.refresh, access: access);

      // Act
      await interceptorUtilities.setTokenWithNewAccessInCache(access);

      // Assert
      verify(() => mockSharedPreferences.setString(
          CachedValues.token, json.encode(newToken.toJson())));
    });
  });
}
