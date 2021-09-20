import 'package:capybara_app/data/requests/chat/message_request.dart';
import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MockSocket extends Mock implements WebSocketChannel {}

void main() {
  final tChatSession = ChatStream(channelConnections: MockSocket());
  final tMessageBody='somebody';
  final tMessageType=SendMessageType();
  final tMessageRequest = MessageRequest(
      messageType: tMessageType, body: tMessageBody, chatStream: tChatSession);
  final tMessageParams=MessageParams(body:tMessageBody,chatStream: tChatSession,messageType: tMessageType);

  test('should be a subclass of add to message params', () async {
    // Assert
    expect(tMessageRequest, isA<MessageParams>());
  });

  test('should return a JSON map from message request', () async {
    // Arrange
    final result = tMessageRequest.toJson();

    // Act
    final expectedJsonMap = {'type': 'new_message', 'body': 'somebody'};

    // Assert
    expect(result, expectedJsonMap);
  });
  test('should create request from params', () async {

    // Act
    final result =MessageRequest.fromParams(tMessageParams) ;

    // Assert
    expect(result, tMessageRequest);
  });
}
