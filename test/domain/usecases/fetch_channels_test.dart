import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelRespository extends Mock implements ChannelRepository {}

void main() {
  late MockChannelRespository mockChannelRespository;
  late FetchChannels usecase;

  setUp(() {
    mockChannelRespository = MockChannelRespository();
    usecase = FetchChannels(channelRepository: mockChannelRespository);
  });
  const String channelNameFirst = 'somebody';
  const String channelNameSecond = 'once';
  List<Channel> channels = [];
  channels.add(Channel(name: channelNameFirst));
  channels.add(Channel(name: channelNameSecond));

  test('should fetch channels', () async {
    //arrange
    when(() => mockChannelRespository.fetchChannels())
        .thenAnswer((_) async => Right(channels));

    //act
    final result = await usecase(NoParams());
    verify(() => mockChannelRespository.fetchChannels());

    //assert
    verifyNoMoreInteractions(mockChannelRespository);

    expect(result, Right(channels));
  });
}
