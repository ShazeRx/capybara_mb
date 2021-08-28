import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/chat/fetch_last_10_msgs_from_timestamp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChatRepository extends Mock implements ChatRepository {}

void main() {
  late MockChatRepository mockChatRepository;
  late FetchLast10MsgsFromTimestamp usecase;
  final String timestamp = '2021-07-21';
  final Message message =
      Message(timestamp, message: 'some', username: 'username');
  final List<Message> messages = [message];
  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = FetchLast10MsgsFromTimestamp(chatRepository: mockChatRepository);
  });

  test('should return last 10 messages', () async {
    //Arrange
    when(() => mockChatRepository.fetchLast10MessagesFromTimestamp(any()))
        .thenAnswer((_) async => Right(messages));

    //Act
    final result = await usecase(FetchMsgParams(timestamp: timestamp));

    //Assert
    verify(
        () => mockChatRepository.fetchLast10MessagesFromTimestamp(timestamp));

    verifyNoMoreInteractions(mockChatRepository);

    expect(result, Right(messages));
  });
}
