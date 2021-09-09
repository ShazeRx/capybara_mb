import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_users.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/facades/channel_facade.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateChannel extends Mock implements CreateChannel {}

class MockAddToChannel extends Mock implements AddToChannel {}

class MockFetchChannels extends Mock implements FetchChannels {}

class MockChannelsState extends Mock implements ChannelsState {}

class MockFetchUsers extends Mock implements FetchUsers {}

class FakeChannelParams extends Fake implements CreateChannelParams {}

void main() {
  late MockCreateChannel mockCreateChannel;
  late MockAddToChannel mockAddToChannel;
  late MockFetchChannels mockFetchChannels;
  late MockChannelsState mockChannelsState;
  late MockFetchUsers mockFetchUsers;
  late ChannelFacade channelFacade;

  setUp(() {
    mockCreateChannel = MockCreateChannel();
    mockAddToChannel = MockAddToChannel();
    mockFetchChannels = MockFetchChannels();
    mockChannelsState = MockChannelsState();
    mockFetchUsers = MockFetchUsers();

    channelFacade = ChannelFacade(
        addToChannel: mockAddToChannel,
        fetchChannels: mockFetchChannels,
        createChannel: mockCreateChannel,
        channelsState: mockChannelsState,
        fetchUsers: mockFetchUsers);
    registerFallbackValue<CreateChannelParams>(FakeChannelParams());
  });
  final users = List.generate(
      4,
      (index) => User(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  final channelName = 'some';
  final channel = Channel(name: channelName, users: users);
  final channelList = [channel];
  final channelParams = CreateChannelParams(
      name: channelName, users: users.map((e) => e.id).toList());
  final addToChannelParams = AddToChannelParams(userId: '1', channelId: '1');
  group('create channel', () {
    test('should call create channel', () async {
      //Arrange
      when(() => mockCreateChannel(any()))
          .thenAnswer((_) async => Right(channel));

      //Act
      await channelFacade.createChannel(channelParams);

      //Assert
      verify(() => mockCreateChannel(channelParams));
    });
  });
  group('fetch channels', () {
    test('should call fetch channels', () async {
      //Arrange
      when(() => mockFetchChannels(NoParams()))
          .thenAnswer((_) async => Right(channelList));

      //Act
      await channelFacade.fetchChannels();

      //Assert
      verify(() => mockFetchChannels(NoParams()));
    });
  });
  group('add to channel', () {
    test('should call add to channel', () async {
      //Arrange
      when(() => mockAddToChannel(addToChannelParams))
          .thenAnswer((_) async => Right(unit));

      //Act
      await channelFacade.addToChannel(addToChannelParams);

      //Assert
      verify(() => mockAddToChannel(addToChannelParams));
    });
  });
  group('fetch users', () {
    test('should call fetch users', () async {
      //Arrange
      when(() => mockFetchUsers(NoParams()))
          .thenAnswer((_) async => Right(users));

      //Act
      await channelFacade.fetchUsers();

      //Assert
      verify(() => mockFetchUsers(NoParams()));
    });
  });
}
