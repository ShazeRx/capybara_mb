import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelRespository extends Mock implements ChannelRepository {}

class FakeChannelParams extends Fake implements AddToChannelParams {}

void main() {
  late MockChannelRespository mockChannelRespository;
  late AddToChannel usecase;

  setUp(() {
    mockChannelRespository = MockChannelRespository();
    usecase = AddToChannel(channelRepository: mockChannelRespository);
    registerFallbackValue(FakeChannelParams());
  });

  final String channelId = '1';
  final String userId = '1';
  final tParams = AddToChannelParams(userId: userId, channelId: channelId);

  test('should create channel', () async {
    //arrange
    when(() => mockChannelRespository.addToChannel(any()))
        .thenAnswer((_) async => Right(unit));

    //act
    final result = await usecase(tParams);

    //assert
    verify(() => mockChannelRespository.addToChannel(tParams));

    verifyNoMoreInteractions(mockChannelRespository);

    expect(result, Right(unit));
  });
}
