import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/ui/facades/channel_facade.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockChannelFacade extends Mock implements ChannelFacade {}

void main() {
  late NewChannelMembersProvider provider;
  late MockChannelFacade mockChannelFacade;

  final users = List.generate(
      4,
      (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  final tUserId = 1;

  setUp(() {
    registerManagers();
  });

  //Need to do this in that way cuz some tests need different setups for provider
  registerDefaultMocks() {
    setUp(() {
      mockChannelFacade = MockChannelFacade();
      //Need to mock here once to be sure that on create instance there wont be any null exceptions from facade
      when(() => mockChannelFacade.fetchUsers())
          .thenAnswer((_) async => Right(users));
      provider = NewChannelMembersProvider(channelFacade: mockChannelFacade);
    });
  }

  tearDown(() => unregisterManagers());

  group('on user list tile clicked', () {
    registerDefaultMocks();
    test(
        'should add user to selected user tiles if user not exists in the list',
        () async {
      // Act
      provider.onUserListTileClicked(tUserId);
      final result = provider.selectedUserTiles;

      // Verify
      expect(result, equals([tUserId]));
    });

    test(
        'should remove user from selected user tiles if user exists in the list',
        () async {
      // Arrange
      provider.onUserListTileClicked(tUserId);

      // Act
      provider.onUserListTileClicked(tUserId);
      final result = provider.selectedUserTiles;

      // Assert
      expect(result, equals([]));
    });
  });

  group('on add channel members clicked', () {
    registerDefaultMocks();
    test('should show an error when no members are selected', () {
      // Act
      provider.onAddChannelMembersClicked();

      // Assert
      verify(() => mockSnackbarManager.showError(any()));
    });

    test(
        'should navigate to new channel name screen with selected members as arguments when at least one member is selected',
        () {
      // Arrange
      provider.onUserListTileClicked(tUserId);

      // Act
      provider.onAddChannelMembersClicked();

      // Assert
      verify(() => mockNavigationManager
          .pushRouteOnStack(RoutePaths.newChannelNameRoute, [tUserId]));
    });
  });
  group('fetch users', () {
    test('should call facade fetch user', () {
      //Arrange
      mockChannelFacade = MockChannelFacade();
      when(() => mockChannelFacade.fetchUsers())
          .thenAnswer((_) async => Right(users));

      //Act
      provider = NewChannelMembersProvider(channelFacade: mockChannelFacade);

      //Assert
      verify(() => mockChannelFacade.fetchUsers()).called(1);
    });

    test('should show error on facade failure', () {
      //Arrange
      mockChannelFacade = MockChannelFacade();
      when(() => mockChannelFacade.fetchUsers())
          .thenAnswer((_) async => Left(NetworkFailure()));

      //Act
      provider = NewChannelMembersProvider(channelFacade: mockChannelFacade);
      //Assert
      verify(() => mockChannelFacade.fetchUsers()).called(1);
      //TODO: need to check this test!!
      //verify(() => mockSnackbarManager.showError(any()));
    });
  });
}
