import 'dart:convert';

import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/data/datasource/channel/channel_local_data_source.dart';
import 'package:capybara_app/data/models/channel/channel_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture_paths.dart';
import '../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ChannelLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        ChannelLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  final channelList = ChannelModel.fromJsonToList(
      json.decode(fixture(FixturePaths.channelsJson)));

  group('fetch channels', () {
    test('should return cached channels if they are available', () async {
      //Arrange
      when(() => mockSharedPreferences.getString(CachedValues.channels))
          .thenReturn(fixture(FixturePaths.channelsJson));

      //Act
      final result = await dataSource.fetchChannels();

      //Assert
      verify(() => mockSharedPreferences.getString(CachedValues.channels));

      expect(result, channelList);
    });
    test('should throw cache exception where there is no cache', () {
      //Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      //Act
      final call = dataSource.fetchChannels;

      //Assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
  group('cache channels', () {
    test('should call shared preferences to cache data', () {
      //Arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);

      //Act
      dataSource.cacheChannels(channelList);

      final expectedJson = json.encode(channelList);

      //Assert
      verify(() =>
          mockSharedPreferences.setString(CachedValues.channels, expectedJson));
    });
  });
}
