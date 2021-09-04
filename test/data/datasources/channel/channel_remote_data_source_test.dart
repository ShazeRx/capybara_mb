import 'dart:convert';
import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/http_methods.dart';
import 'package:capybara_app/core/errors/exceptions/client_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/http/http_client.dart';
import 'package:capybara_app/data/datasource/channel/channel_remote_data_source.dart';
import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/data/models/channel/channel_model.dart';
import 'package:capybara_app/data/requests/channel/add_to_channel_request.dart';
import 'package:capybara_app/data/requests/channel/channel_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_paths.dart';
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
  const String channelId = '1';
  const String userId = '1';
  List<ChannelModel> channels = [];
  final users = List.generate(
      4,
      (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  channels.add(ChannelModel(
      name: channelNameFirst, users: users.getRange(0, 2).toList()));
  channels.add(ChannelModel(
      name: channelNameSecond, users: users.getRange(2, 4).toList()));
  final tChannelRequest = CreateChannelRequest(name: channelNameFirst, users: [0,1]);
  final tAddToChannelRequest =
      AddToChannelRequest(channelId: channelId, userId: userId);
  final tChannelModel =
      ChannelModel.fromJson(json.decode(fixture(FixturePaths.channelJson)));
  group('create channel', () {
    setUp(() {
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'),
              method: HttpMethods.post,
              body: tChannelRequest.toJson()))
          .thenAnswer((_) async => fixture((FixturePaths.channelJson)));
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
    test('should throw ClientException', () {
      //Arrange
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'),
              method: HttpMethods.post,
              body: tChannelRequest.toJson()))
          .thenThrow(ClientException(message: 'Fail'));

      //Act
      final call = dataSource.createChannel;

      //Assert
      expect(
          () => call(tChannelRequest), throwsA(TypeMatcher<ClientException>()));
    });
  });

  group('fetch channel', () {
    setUp(() {
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'), method: HttpMethods.get))
          .thenAnswer((_) async => fixture((FixturePaths.channelsJson)));
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
    test('should throw ClientException', () {
      //Arrange
      when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.get)).thenThrow(ClientException(message: 'Fail'));

      //Act
      final call = dataSource.fetchChannels;

      //Assert
      expect(() => call(), throwsA(TypeMatcher<ClientException>()));
    });
  });
  group('add to channel', () {
    setUp(() {
      when(() => mockHttpClient.invoke(
          url: any(named: 'url'),
          method: HttpMethods.post,
          body: tAddToChannelRequest.toJson())).thenAnswer((_) async => Unit);
    });

    test('should add to channel', () async {
      //Act //Assert
      await dataSource.addToChannel(tAddToChannelRequest);
    });

    test('should throw ServerException', () async {
      //Arrange
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'),
              method: HttpMethods.post,
              body: tAddToChannelRequest.toJson()))
          .thenThrow(ServerException(message: 'Fail'));

      //Act
      final call = dataSource.addToChannel;

      //Assert
      expect(() => call(tAddToChannelRequest),
          throwsA(TypeMatcher<ServerException>()));
    });
    test('should throw ClientException', () async {
      //Arrange
      when(() => mockHttpClient.invoke(
              url: any(named: 'url'),
              method: HttpMethods.post,
              body: tAddToChannelRequest.toJson()))
          .thenThrow(ClientException(message: 'Fail'));

      //Act
      final call = dataSource.addToChannel;

      //Assert
      expect(() => call(tAddToChannelRequest),
          throwsA(TypeMatcher<ClientException>()));
    });
  });
}
