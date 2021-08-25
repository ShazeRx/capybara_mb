import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/chat/create_channel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelRespository extends Mock implements ChannelRepository {}

void main() {
  late MockChannelRespository mockChannelRespository;
  late CreateChannel usecase;

  setUp(() {
    mockChannelRespository = MockChannelRespository();
    usecase = CreateChannel(channelRepository: mockChannelRespository);
  });
  const String channelName = 'somebody';
  final Channel channel = Channel(name: channelName);

  test('should create channel', () async {
    //arrange
    when(() => mockChannelRespository.createChannel(any()))
        .thenAnswer((_) async => Right(channel));

    //act
    final result = await usecase(ChannelParams(name: channelName));
    verify(() => mockChannelRespository.createChannel(channelName));

    //assert
    verifyNoMoreInteractions(mockChannelRespository);

    expect(result, Right(channel));
  });
}
