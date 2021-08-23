import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/chat/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockChatRepository;
  late SendMessage usecase;
  const String messageBody = 'somebody';
  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = SendMessage(chatRepository: mockChatRepository);
  });
  test('should send message', () async {
    //Arrange
    when(() => mockChatRepository.sendMessage(any()))
        .thenAnswer((_) async => Right(null));

    //Act
    final result = await usecase(MessageParams(body: messageBody));

    //Assert

    verify(() => mockChatRepository.sendMessage(messageBody));

    expect(result, Right(null));
  });
}
