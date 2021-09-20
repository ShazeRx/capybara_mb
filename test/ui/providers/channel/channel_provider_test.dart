import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_channels.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/providers/channels/channel_provider.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockChannelsState extends Mock implements ChannelsState {}

class MockFetchChannels extends Mock implements FetchChannels {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockFetchChannels mockFetchChannels;
  late ChannelProvider channelProvider;
  late MockChannelsState mockChannelsState;

  setUp(() {
    registerManagers();
    mockChannelsState = MockChannelsState();
    mockFetchChannels = MockFetchChannels();
    registerFallbackValue(FakeNoParams());
    when(() => mockFetchChannels(any()))
        .thenAnswer((_) async => Left(ServerFailure(message: 'xd')));
    channelProvider = ChannelProvider(
        fetchChannels: mockFetchChannels, channelsState: mockChannelsState);
  });

  tearDown(() => unregisterManagers());

  final users = List.generate(
      4,
      (index) =>
          User(id: index, username: 'some$index', email: 'some$index@body.pl'));
  final channelName = 'some';
  final channel = Channel(name: channelName, users: users);
  final channelList = [channel];
  group('fetch channels', () {
    test('should call fetch channels', () async {
      //Arrange
      when(() => mockFetchChannels(any()))
          .thenAnswer((_) async => Right(channelList));

      //Act
      await channelProvider.fetchChannels();

      //Assert
      verify(() => mockFetchChannels(any()));
    });
    test('should show error snackbar on failure', () async {
      //Arrange
      when(() => mockFetchChannels(any()))
          .thenAnswer((_) async => Left(ServerFailure(message: 'xd')));

      //Act
      await channelProvider.fetchChannels();

      //Assert
      verify(() => mockSnackbarManager.showError(any()));
    });
  });
}
