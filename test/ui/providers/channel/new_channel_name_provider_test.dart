import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_name_provider.dart';
import 'package:capybara_app/ui/states/channel/channel_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockCreateChannelUsecase extends Mock implements CreateChannel {}

class MockChannelsState extends Mock implements ChannelsState {}

class FakeCreateChannelParams extends Fake implements CreateChannelParams {}

void main() {
  late NewChannelNameProvider provider;
  late MockCreateChannelUsecase mockCreateChannelUsecase;

  setUp(() {
    registerManagers();
    mockCreateChannelUsecase = new MockCreateChannelUsecase();
    provider = NewChannelNameProvider(createChannel: mockCreateChannelUsecase);
    registerFallbackValue(FakeCreateChannelParams());
  });

  final membersList = [1, 2];
  final channel = Channel(
      name: 'some',
      users: [User(id: 0, username: 'some', email: 'body@once.pl')]);

  tearDown(() => unregisterManagers());

  group('on add channel clicked', () {
    test('should show error when channel name is empty', () async {
      // Arrange
      provider.channelNameController.text = '';

      // Act
      provider.onAddChannelClicked([]);

      // Assert
      verify(() => mockSnackbarManager.showError(any()));
    });
    test('should navigate to home when channel created', () async {
      //Arrange
      provider.channelNameController.text = 'abc';
      when(() => mockCreateChannelUsecase(any()))
          .thenAnswer((_) async => Right(channel));

      //Act
      await provider.onAddChannelClicked(membersList);

      //Assert
      verify(() => mockNavigationManager.navigateTo(RoutePaths.homeRoute));
    });
    test('should call create channel usecase', () async {
      //Arrange
      provider.channelNameController.text = 'abc';
      when(() => mockCreateChannelUsecase(any()))
          .thenAnswer((_) async => Right(channel));

      //Act
      await provider.onAddChannelClicked(membersList);

      //Assert
      verify(() => mockCreateChannelUsecase(any())).called(1);
    });
    test('should show error when failed adding channel', () async {
      //Arrange
      provider.channelNameController.text = 'abc';
      when(() => mockCreateChannelUsecase(any()))
          .thenAnswer((_) async => Left(ServerFailure(message: 'xd')));

      //Act
      await provider.onAddChannelClicked(membersList);

      //Assert
      verify(() => mockSnackbarManager.showError(any()));
    });
  });
}
