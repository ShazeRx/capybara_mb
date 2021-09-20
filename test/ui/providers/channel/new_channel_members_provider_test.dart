import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/domain/usecases/channel/fetch_users.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/providers/channels/new_channel_members_provider.dart';
import 'package:capybara_app/ui/states/user/users_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockFetchUserUsecase extends Mock implements FetchUsers {}

class MockUsersState extends Mock implements UsersState {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late NewChannelMembersProvider provider;
  late MockUsersState mockUsersState;
  late MockFetchUserUsecase mockFetchUsersUsecase;
  final users = List.generate(
      4,
      (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  final tUserId = 1;

  setUp(() {
    registerManagers();
    mockUsersState = MockUsersState();
    mockFetchUsersUsecase = MockFetchUserUsecase();
    registerFallbackValue(FakeNoParams());
  });

  tearDown(() => unregisterManagers());

  mockFetchFailure() {
    reset(mockFetchUsersUsecase);
    when(() => mockFetchUsersUsecase(any()))
        .thenAnswer((_) async => Left(ServerFailure(message: 'xd')));
    provider = NewChannelMembersProvider(
        fetchUsers: mockFetchUsersUsecase, usersState: mockUsersState);
  }

  mockFetchSuccess() {
    when(() => mockFetchUsersUsecase(any()))
        .thenAnswer((_) async => Right(users));
    provider = NewChannelMembersProvider(
        fetchUsers: mockFetchUsersUsecase, usersState: mockUsersState);
  }

  group('on user list tile clicked', () {
    test(
        'should add user to selected user tiles if user not exists in the list',
        () async {
      //Arrange
      mockFetchSuccess();

      // Act
      provider.onUserListTileClicked(tUserId);
      final result = provider.selectedUserTiles;

      // Verify
      expect(result, equals([tUserId]));
    });

    test(
        'should remove user from selected user tiles if user exists in the list',
        () async {
      //Arrange
      mockFetchSuccess();
      provider.onUserListTileClicked(tUserId);

      // Act
      provider.onUserListTileClicked(tUserId);
      final result = provider.selectedUserTiles;

      // Assert
      expect(result, equals([]));
    });
  });

  group('on add channel members clicked', () {
    test('should show an error when no members are selected', () {
      //Arrange
      mockFetchSuccess();

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
    test('should call fetch user usecase', () {
      //Arrange
      mockFetchSuccess();

      //Assert
      verify(() => mockFetchUsersUsecase.call(any())).called(1);
    });

    test('should show error on facade failure', () {
      //Arrange
      mockFetchFailure();

      //Assert
      verify(() => mockFetchUsersUsecase.call(any())).called(1);
      //TODO: need to check this test!!
      //verify(() => mockSnackbarManager.showError(any()));
    });
  });
}
