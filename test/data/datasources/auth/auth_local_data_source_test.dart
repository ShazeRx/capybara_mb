import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AuthLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = AuthLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  final tTokenModel =
      TokenModel.fromJson(json.decode(fixture(FixturePaths.tokenJson)));

  group('fetch token', () {
    test(
        'should return token from shared preferences when there is one in the cache',
        () async {
      // Arrange
      when(() => mockSharedPreferences.getString(CachedValues.token))
          .thenReturn(fixture(FixturePaths.tokenJson));

      // Act
      final result = await dataSource.fetchToken();

      // Assert
      verify(() => mockSharedPreferences.getString(CachedValues.token));

      expect(result, equals(tTokenModel));
    });

    test('should throw a CacheException where there is not cached value', () {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      // Act
      // Not calling the method here, just storing it inside a call variable
      final call = dataSource.fetchToken;

      // Assert
      // Calling the method happens from a higher-order function passed.
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cache token', () {
    test('should call shared preferences to cache the data', () {
      // Arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      // Act
      dataSource.cacheToken(tTokenModel);

      final expectedJsonString = json.encode(tTokenModel.toJson());

      // Assert
      verify(() => mockSharedPreferences.setString(
            CachedValues.token,
            expectedJsonString,
          ));
    });
  });
}
