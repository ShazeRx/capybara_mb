import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelRespository extends Mock implements ChannelRepository {}

class FakeChannelParams extends Fake implements ChannelParams {}

void main() {
  late MockChannelRespository mockChannelRespository;
  late CreateChannel usecase;

  setUp(() {
    mockChannelRespository = MockChannelRespository();
    usecase = CreateChannel(channelRepository: mockChannelRespository);
    registerFallbackValue(FakeChannelParams());
  });
  const String channelName = 'somebody';
  final users = List.generate(
      2,
      (index) =>
          User(id: index, username: 'some$index', email: 'some$index@body.pl'));
  final Channel channel = Channel(name: channelName,users:users);
  final tParams = ChannelParams(name: channelName,users: users);

  test('should create channel', () async {
    //arrange
    when(() => mockChannelRespository.createChannel(any()))
        .thenAnswer((_) async => Right(channel));

    //act
    final result = await usecase(tParams);
    verify(() => mockChannelRespository.createChannel(tParams));

    //assert
    verifyNoMoreInteractions(mockChannelRespository);

    expect(result, Right(channel));
  });
}
