import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:capybara_app/domain/usecases/auth/fetch_token.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthState extends Mock implements AuthState {}

class MockFetchToken extends Mock implements FetchToken {}

class MockLoginUser extends Mock implements LoginUser {}

class MockRegisterUser extends Mock implements RegisterUser {}

class FakeLoginParams extends Fake implements LoginParams {}

class FakeNoParams extends Fake implements NoParams {}

class FakeRegisterParams extends Fake implements RegisterParams {}

void main() {
  late MockAuthState mockAuthState;
  late MockFetchToken mockFetchToken;
  late MockLoginUser mockLoginUser;
  late MockRegisterUser mockRegisterUser;
  late AuthFacade authFacade;

  setUp(() {
    mockAuthState = MockAuthState();
    mockFetchToken = MockFetchToken();
    mockLoginUser = MockLoginUser();
    mockRegisterUser = MockRegisterUser();
    authFacade = AuthFacade(
      authState: mockAuthState,
      fetchToken: mockFetchToken,
      loginUser: mockLoginUser,
      registerUser: mockRegisterUser,
    );

    registerFallbackValue<LoginParams>(FakeLoginParams());
    registerFallbackValue<NoParams>(FakeNoParams());
    registerFallbackValue<RegisterParams>(FakeRegisterParams());
  });

  final tId = 1;
  final tUsername = 'user';
  final tEmail = 'user@user.com';
  final tPassword = 'user123';
  final tToken = Token(refresh: '123', access: '321');
  final tUser = User(id: tId, email: tEmail, username: tUsername);
  final tLoginParams = LoginParams(username: 'user', password: 'user123');
  final tRegisterParams =
      RegisterParams(username: tUsername, email: tEmail, password: tPassword);

  group('fetch token', () {
    test('should call fetch token', () {
      // Arrange
      when(() => mockFetchToken(any())).thenAnswer((_) async => Right(tToken));

      // Act
      authFacade.fetchToken();

      // Assert
      verify(() => mockFetchToken(NoParams()));
    });

    test('should set token result in state', () async {
      // Arrange
      when(() => mockFetchToken(any())).thenAnswer((_) async => Right(tToken));

      // Act
      await authFacade.fetchToken();

      // Assert
      verify(() => mockAuthState.setToken(tToken));
    });

    test('should set null result in state', () async {
      // Arrange
      when(() => mockFetchToken(any()))
          .thenAnswer((_) async => Left(NetworkFailure()));

      // Act
      await authFacade.fetchToken();

      // Assert
      verify(() => mockAuthState.setToken(null));
    });
  });

  group('login user', () {
    test('should call login user', () {
      // Arrange
      when(() => mockLoginUser(any())).thenAnswer((_) async => Right(tToken));

      // Act
      authFacade.loginUser(tLoginParams);

      // Assert
      verify(() => mockLoginUser(tLoginParams));
    });

    test('should set token result in state', () async {
      // Arrange
      when(() => mockLoginUser(any())).thenAnswer((_) async => Right(tToken));

      // Act
      await authFacade.loginUser(tLoginParams);

      // Assert
      verify(() => mockAuthState.setToken(tToken));
    });

    test('should set null result in state', () async {
      // Arrange
      when(() => mockLoginUser(any()))
          .thenAnswer((_) async => Left(NetworkFailure()));

      // Act
      await authFacade.loginUser(tLoginParams);

      // Assert
      verify(() => mockAuthState.setToken(null));
    });
  });

  group('register user', () {
    test('should call register user', () {
      // Arrange
      when(() => mockRegisterUser(any())).thenAnswer((_) async => Right(tUser));

      // Act
      authFacade.registerUser(tRegisterParams);

      // Assert
      verify(() => mockRegisterUser(tRegisterParams));
    });

    test('should set user result in state', () async {
      // Arrange
      when(() => mockRegisterUser(any())).thenAnswer((_) async => Right(tUser));

      // Act
      await authFacade.registerUser(tRegisterParams);

      // Assert
      verify(() => mockAuthState.setUser(tUser));
    });

    test('should set null result in state', () async {
      // Arrange
      when(() => mockRegisterUser(any()))
          .thenAnswer((_) async => Left(NetworkFailure()));

      // Act
      await authFacade.registerUser(tRegisterParams);

      // Assert
      verify(() => mockAuthState.setUser(null));
    });
  });
}
