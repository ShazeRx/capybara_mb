import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/chat/message_params.dart';
import 'package:capybara_app/domain/usecases/chat/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MockChatRepository extends Mock implements ChatRepository {}
class MockSocket extends Mock implements WebSocketChannel{}

void main() {
  late MockChatRepository mockChatRepository;
  late SendMessage usecase;
  const String messageBody = 'somebody';
  final chatSession = ChatStream(streamChannel: MockSocket());
  final messageList=[Message('21.02.1234', message: 'some', username: 'body')];
  final messageParams=MessageParams(body: messageBody,chatStream: chatSession,messageType:SendMessageType());
  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = SendMessage(chatRepository: mockChatRepository);
  });
  test('should send message', () async {
    //Arrange
    when(() => mockChatRepository.sendMessage(messageParams))
        .thenAnswer((_) async => Right(messageList));

    //Act
    final result = await usecase(messageParams);

    //Assert

    verify(() => mockChatRepository.sendMessage(messageParams));

    expect(result, Right(messageList));
  });
}
