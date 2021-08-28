import 'dart:convert';

import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/http_methods.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/http/http_client.dart';
import 'package:capybara_app/data/datasource/chat/channel_remote_data_source.dart';
import 'package:capybara_app/data/models/channel_model.dart';
import 'package:capybara_app/data/requests/chat/channel_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late ChannelRemoteDataSource dataSource;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ChannelRemoteDataSourceImpl(client: mockHttpClient);
  });
  const String channelNameFirst = 'somebody';
  const String channelNameSecond = 'once';
  List<ChannelModel> channels = [];
  channels.add(ChannelModel(name: channelNameFirst));
  channels.add(ChannelModel(name: channelNameSecond));
  final tChannelRequest = ChannelRequest(name: channelNameFirst);
  final tChannelModel =
      ChannelModel.fromJson(json.decode(fixture('channel.json')));
  group('create channel', () {
    setUp(() {
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'),
              method: HttpMethods.post,
              body: tChannelRequest.toJson()))
          .thenAnswer((_) async => fixture('channel.json'));
    });
    test('should create channel', () async {
      //Act
      final result = await dataSource.createChannel(tChannelRequest);

      //Assert
      verify(() => mockHttpClient.invoke(
          url: Api.channelUrl,
          method: HttpMethods.post,
          body: tChannelRequest.toJson()));
      expect(result, tChannelModel);
    });
    test('should throw ServerException', () {
      //Arrange
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'),
              method: HttpMethods.post,
              body: tChannelRequest.toJson()))
          .thenThrow(ServerException(message: 'Fail'));

      //Act
      final call = dataSource.createChannel;

      //Assert
      expect(
          () => call(tChannelRequest), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('fetch channel', () {
    setUp(() {
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'), method: HttpMethods.get))
          .thenAnswer((_) async => fixture('channels.json'));
    });
    test('should return channels', () async {
      //Act
      final result = await dataSource.fetchChannels();

      //Assert
      verify(() =>
          mockHttpClient.invoke(url: Api.channelUrl, method: HttpMethods.get));

      expect(result, channels);
    });
    test('should throw ServerException', () {
      //Arrange
      when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.get)).thenThrow(ServerException(message: 'Fail'));

      //Act
      final call = dataSource.fetchChannels;

      //Assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
  group('add to channel', () {});
}
