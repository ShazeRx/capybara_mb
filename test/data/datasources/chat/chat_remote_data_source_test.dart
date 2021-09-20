import 'dart:convert';

import 'package:capybara_app/core/constants/api.dart';
import 'package:capybara_app/core/constants/cached_values.dart';
import 'package:capybara_app/core/protocols/token_utilites.dart';
import 'package:capybara_app/core/protocols/websocket/socket_client.dart';
import 'package:capybara_app/data/datasource/chat/chat_remote_data_source.dart';
import 'package:capybara_app/data/models/auth/token_model.dart';
import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MockConnection extends Mock implements WebSocketChannel {}

class MockSocketClient extends Mock implements SocketClient {}

class MockTokenUtilities extends Mock implements TokenUtilities {}

class MockUri extends Fake implements Uri {}

void main() async {
  late ChatRemoteDataSource chatRemoteDataSource;
  late MockConnection mockSocketConnection;
  late MockSocketClient mockSocketClient;
  setUp(() {
    mockSocketClient = MockSocketClient();
    mockSocketConnection = MockConnection();
    chatRemoteDataSource =
        ChatRemoteDataSourceImpl(socketClient: mockSocketClient);
    registerFallbackValue(MockUri());
  });
  final tToken = TokenModel(refresh: '123', access: '321');
  SharedPreferences.setMockInitialValues(
      {CachedValues.token: json.encode(tToken.toJson())});
  final tChannelId = 1;

  group('fetch last 10 messages', () {
    test('should fetch the last 10 messages', () {});
  });
  group('fetch last 10 messages from timestamp', () {});
  group('send message', () {
    test('test should send message', () {

    });
    test('should call socket client', () {});
  });
  group('join chat session', () {
    test('should join channel', () async {
      //Arrange
      final chatStream = ChatStream(channelConnections: mockSocketConnection);
      when(() => mockSocketClient.connect(any()))
          .thenReturn(mockSocketConnection);

      //Act
      final result = await chatRemoteDataSource.joinChatSession(tChannelId);

      //Assert
      expect(result, chatStream);
    });

    test('should call to socket client', () async {
      //Arrange
      when(() => mockSocketClient.connect(any()))
          .thenReturn(mockSocketConnection);

      //Act
      final _ = await chatRemoteDataSource.joinChatSession(tChannelId);

      //Assert
      verify(() => mockSocketClient.connect(any()));
    });

    // test('should call to socket client with valid correct url', () async {
    //   //Arrange
    //   when(() => mockSocketClient.connect(any()))
    //       .thenReturn(mockSocketConnection);
    //
    //   //Act
    //   final _ = await chatRemoteDataSource.joinChatSession(tChannelId);
    //
    //   //Assert
    //   verify(() => mockSocketClient.connect(Uri.parse(Api.baseSocketUrl +
    //       sprintf(Api.socketJoinChannelUrl, [tChannelId, tToken.access]))));
    // });
  });
}
