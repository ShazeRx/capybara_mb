import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelRespository extends Mock implements ChannelRepository {}

class FakeChannelParams extends Fake implements CreateChannelParams {}

void main() {
  late MockChannelRespository mockChannelRespository;
  late CreateChannel usecase;

  setUp(() {
    mockChannelRespository = MockChannelRespository();
    usecase = CreateChannel(channelRepository: mockChannelRespository);
    registerFallbackValue(FakeChannelParams());
  });
  const String channelName = 'somebody';
  final usersIds = Iterable<int>.generate(2).toList();
  final userList=List<User>.generate(usersIds.length,(e)=>User(id:usersIds[e],username:'some$e',email:'some$e@body.pl'));
  final Channel channel = Channel(name: channelName,users:userList);
  final tParams = CreateChannelParams(name: channelName,users: usersIds);

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
