import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/profile/user_profile_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockAuthFacade extends Mock implements AuthFacade {}

void main() {
  late MockAuthFacade mockAuthFacade;

  late UserProfileProvider provider;

  setUp(() {
    registerManagers();
    mockAuthFacade = MockAuthFacade();
    provider = UserProfileProvider(
      authFacade: mockAuthFacade,
    );
  });

  tearDown(() => unregisterManagers());

  void mockLogoutFailure() {
    when(() => mockAuthFacade.logoutUser())
        .thenAnswer((_) async => Left(CacheFailure()));
  }

  void mockLogoutSuccess() {
    when(() => mockAuthFacade.logoutUser())
        .thenAnswer((_) async => Right(unit));
  }

  group('on logout pressed', () {
    test('should call logout usecase with no params', () async {
      // Arrange
      mockLogoutSuccess();

      // Act
      await provider.onLogoutPressed();

      // Assert
      verify(() => mockAuthFacade.logoutUser());

      verifyNoMoreInteractions(mockAuthFacade);
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
}
