import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/providers/auth/login_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../setup/test_helpers.dart';

class MockAuthFacade extends Mock implements AuthFacade {}

class FakeParams extends Fake implements LoginParams {}

void main() {
  late LoginProvider provider;
  late MockAuthFacade mockAuthFacade;

  setUp(() {
    registerThirdPartyServices();

    mockAuthFacade = MockAuthFacade();

    provider = LoginProvider(
      authFacade: mockAuthFacade,
    );
    registerFallbackValue<LoginParams>(FakeParams());
  });

  tearDown(() => unregisterThirdPartyServices());

  final tUsername = 'user';
  final tPassword = 'user123';
  final tToken = Token(access: '123', refresh: '321');

  void mockLoginSuccess() {
    when(() => mockAuthFacade.loginUser(any())).thenAnswer(
      (_) async => Right(tToken),
    );
  }

  void mockLoginfailure() {
    when(() => mockAuthFacade.loginUser(any())).thenAnswer(
      (_) async => Left(ServerFailure(message: 'Server failure')),
    );
  }

  void assignValidLoginData() {
    provider.loginData = {
      'username': tUsername,
      'password': tPassword,
    };
  }

  test('should return valid login params', () {
    // Arrange
    assignValidLoginData();

    // Act
    final result = provider.getLoginParams();

    // Arrange
    expect(result, LoginParams(username: tUsername, password: tPassword));
  });

  group('on login submitted', () {
    setUp(() {
      assignValidLoginData();
    });

    test('should call login use case with valid params', () async {
      // Arrange
      mockLoginSuccess();

      // Act
      provider.onLoginSubmitted();

      // Assert
      verify(() => mockAuthFacade
          .loginUser(LoginParams(username: tUsername, password: tPassword)));
    });

    test('should change provider state to idle after unsuccessful login',
        () async {
      // Arrange
      mockLoginfailure();

      // Act
      await provider.onLoginSubmitted();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.idle);
    });

    test('should change provider state to idle after succesful login',
        () async {
      // Arrange
      mockLoginSuccess();

      // Act
      await provider.onLoginSubmitted();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.idle);
    });

    test('should change provider state to busy after login attempt', () async {
      // Arrange
      mockLoginSuccess();

      // Act
      provider.onLoginSubmitted();
      final result = provider.state;

      // Assert
      expect(result, ProviderState.busy);
    });

    test('should show snackbar with error after unsuccessful login', () async {
      // Arrange
      mockLoginfailure();

      // Act
      await provider.onLoginSubmitted();

      // Assert
      verify(() =>
          mockSnackbarService.showSnackbar(message: any(named: 'message')));
    });
  });
}
