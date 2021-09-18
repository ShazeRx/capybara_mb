import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/domain/usecases/auth/logout_user.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/providers/profile/user_profile_provider.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockTokenState extends Mock implements TokenState {}

class MockUserState extends Mock implements UserState {}

class MockLogoutUser extends Mock implements LogoutUser {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockUserState mockUserState;
  late MockTokenState mockTokenState;
  late MockLogoutUser mockLogoutUser;

  late UserProfileProvider provider;

  setUp(() {
    registerManagers();

    mockUserState = MockUserState();
    mockTokenState = MockTokenState();
    mockLogoutUser = MockLogoutUser();

    provider = UserProfileProvider(
      logoutUser: mockLogoutUser,
      tokenState: mockTokenState,
      userState: mockUserState,
    );

    registerFallbackValue<NoParams>(FakeNoParams());
  });

  tearDown(() => unregisterManagers());

  void mockLogoutFailure() {
    when(() => mockLogoutUser(NoParams()))
        .thenAnswer((_) async => Left(CacheFailure()));
  }

  void mockLogoutSuccess() {
    when(() => mockLogoutUser(NoParams())).thenAnswer((_) async => Right(unit));
  }

  group('on logout pressed', () {
    test('should call logout usecase with no params', () async {
      // Arrange
      mockLogoutSuccess();

      // Act
      await provider.onLogoutPressed();

      // Assert
      verify(() => mockLogoutUser(NoParams()));
    });

    test('should change provider state to idle after unsuccessful logout',
        () async {
      // Arrange
      mockLogoutSuccess();

      // Act
      await provider.onLogoutPressed();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.idle);
    });

    test('should change provider state to idle after succesful logout',
        () async {
      // Arrange
      mockLogoutSuccess();

      // Act
      await provider.onLogoutPressed();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.idle);
    });

    test('should change provider state to busy after logout attempt', () async {
      // Arrange
      mockLogoutSuccess();

      // Act
      provider.onLogoutPressed();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.busy);
    });

    test('should show snackbar with error after unsuccessful logout', () async {
      // Arrange
      mockLogoutFailure();

      // Act
      await provider.onLogoutPressed();

      // Assert
      verify(() => mockSnackbarManager.showError(any()));
    });

    test('should navigate to login screen after successful logout', () async {
      // Arrange
      mockLogoutSuccess();

      // Act
      await provider.onLogoutPressed();

      // Assert
      verify(() => mockNavigationManager.navigateTo((RoutePaths.loginRoute)));
    });
  });

  test('should set token as null value in state when logout is successful',
      () async {
    // Arrange
    mockLogoutSuccess();

    // Act
    await provider.onLogoutPressed();

    // Assert
    verify(() => mockTokenState.setToken(null));
  });

  test('should set user as null value in state when logout is successful',
      () async {
    // Arrange
    mockLogoutSuccess();

    // Act
    await provider.onLogoutPressed();

    // Assert
    verify(() => mockUserState.setUser(null));
  });
}
