import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/auth/register_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockAuthFacade extends Mock implements AuthFacade {}

class FakeParams extends Fake implements RegisterParams {}

void main() {
  late RegisterProvider provider;
  late MockAuthFacade mockAuthFacade;

  setUp(() {
    registerManagers();

    mockAuthFacade = MockAuthFacade();

    provider = RegisterProvider(
      authFacade: mockAuthFacade,
    );

    registerFallbackValue<RegisterParams>(FakeParams());
  });

  tearDown(() => unregisterManagers());

  final tId = 1;
  final tUsername = 'user';
  final tEmail = 'user@user.com';
  final tPassword = 'user123';
  final tUser = User(id: tId, email: tEmail, username: tUsername);

  void mockRegisterSuccess() {
    when(() => mockAuthFacade.registerUser(any())).thenAnswer(
      (_) async => Right(tUser),
    );
  }

  void mockRegisterFailure() {
    when(() => mockAuthFacade.registerUser(any())).thenAnswer(
      (_) async => Left(ServerFailure(message: 'Server failure')),
    );
  }

  void assignValidRegisterData() {
    provider.registerData = {
      'username': tUsername,
      'email': tEmail,
      'password': tPassword,
    };
  }

  test('should return valid register params', () {
    // Arrange
    assignValidRegisterData();

    // Act
    final result = provider.getRegisterParams();

    // Arrange
    expect(
        result,
        RegisterParams(
          username: tUsername,
          email: tEmail,
          password: tPassword,
        ));
  });

  group('on register submitted', () {
    setUp(() {
      assignValidRegisterData();
    });

    test('should call register use case with valid params', () async {
      // Arrange
      mockRegisterSuccess();

      // Act
      provider.onRegisterSubmitted();

      // Assert
      verify(() => mockAuthFacade.registerUser(RegisterParams(
            username: tUsername,
            email: tEmail,
            password: tPassword,
          )));
    });

    test('should change provider state to idle after unsuccessful register',
        () async {
      // Arrange
      mockRegisterFailure();

      // Act
      await provider.onRegisterSubmitted();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.idle);
    });

    test('should change provider state to idle after succesful register',
        () async {
      // Arrange
      mockRegisterSuccess();

      // Act
      await provider.onRegisterSubmitted();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.idle);
    });

    test('should change provider state to busy after register attempt',
        () async {
      // Arrange
      mockRegisterSuccess();

      // Act
      provider.onRegisterSubmitted();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.busy);
    });

    test('should show snackbar with error after unsuccessful register',
        () async {
      // Arrange
      mockRegisterFailure();

      // Act
      await provider.onRegisterSubmitted();

      // Assert
      verify(() => mockSnackbarManager.showError(any()));
    });

    test('should show snackbar with information about email confirmation',
        () async {
      // Arrange
      mockRegisterSuccess();

      // Act
      await provider.onRegisterSubmitted();

      // Assert
      verify(() => mockSnackbarManager.showSuccess(any()));
    });

    test('should back to login screen after successful register', () async {
      // Arrange
      mockRegisterSuccess();

      // Act
      await provider.onRegisterSubmitted();

      // Assert
      verify(() => mockNavigationManager.backToPreviousScreen());
    });
  });
}
