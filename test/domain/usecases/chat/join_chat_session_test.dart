import 'package:capybara_app/domain/entities/chat/chat_stream.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:capybara_app/domain/usecases/chat/join_chat_session.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class MockChatRepository extends Mock implements ChatRepository {}

class MockSocket extends Mock implements WebSocketChannel{}

class MockJoinChannelSessionParams extends Fake implements JoinChannelSessionParams{}

void main() {
  late MockChatRepository mockChatRepository;
  late JoinChatSession usecase;
  final tChannelId = 1;
  final tJoinToChannelParams = JoinChannelSessionParams(channelId: tChannelId);
  final chatSession = ChatStream(streamChannel: MockSocket());
  setUp(() {
    mockChatRepository = MockChatRepository();
    usecase = JoinChatSession(chatRepository: mockChatRepository);
    registerFallbackValue(MockJoinChannelSessionParams());
  });
  test('should join chat session', () async {
    //Arrange
    when(() => mockChatRepository.joinChatSession(any()))
        .thenAnswer((_) async => Right(chatSession));

    //Act
    final result = await usecase(tJoinToChannelParams);

    //Assert
    verify(() => mockChatRepository.joinChatSession(tJoinToChannelParams));

    expect(result, Right(chatSession));
  });
}
