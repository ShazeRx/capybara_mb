import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/chat/fetch_last_10_msgs_from_timestamp.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MockChatRepository extends Mock implements ChatRepository {}

class MockSocket extends Mock implements WebSocketChannel {}

void main() {
  late MockChatRepository mockChatRepository;
  late FetchLast10MsgsFromTimestamp usecase;
  final String timestamp = '2021-07-21';
  final chatSession = ChatStream(streamChannel: MockSocket());
  final messageList=[Message('21.02.1234', message: 'some', username: 'body')];
  final messageParams = MessageParams(
      body: timestamp,
      chatStream: chatSession,
      messageType: FetchLast10MessagesType());
  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = FetchLast10MsgsFromTimestamp(chatRepository: mockChatRepository);
  });

  test('should return last 10 messages from timestamp', () async {
    //Arrange
    when(() => mockChatRepository.fetchLast10MessagesFromTimestamp(messageParams))
        .thenAnswer((_) async => Right(messageList));

    //Act
    final result = await usecase(messageParams);

    //Assert
    verify(() =>
        mockChatRepository.fetchLast10MessagesFromTimestamp(messageParams));

    verifyNoMoreInteractions(mockChatRepository);

    expect(result, Right(messageList));
  });
}
