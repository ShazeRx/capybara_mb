import 'package:capybara_app/domain/entities/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/chat/fetch_last_10_msgs.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockChatRepository;
  late FetchLast10Msgs usecase;
  final Message message = Message(null, message: 'some', username: 'username');
  final List<Message> messages = [message];
  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = FetchLast10Msgs(chatRepository: mockChatRepository);
  });

  test('should return last 10 messages', () async {
    //Arrange
    when(() => mockChatRepository.fetchLast10Messages())
        .thenAnswer((_) async => Right(messages));

    //Act
    final result = await usecase(NoParams());

    //Assert
    verify(() => mockChatRepository.fetchLast10Messages());

    verifyNoMoreInteractions(mockChatRepository);

    expect(result, Right(messages));
  });
}
