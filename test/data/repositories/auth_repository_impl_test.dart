import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:capybara_app/data/models/token_model.dart';
import 'package:capybara_app/data/models/user_model.dart';
import 'package:capybara_app/data/repositories/auth_repository_impl.dart';
import 'package:capybara_app/data/requests/auth/login_request.dart';
import 'package:capybara_app/data/requests/auth/refresh_request.dart';
import 'package:capybara_app/data/requests/auth/register_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class FakeLoginRequest extends Fake implements LoginRequest {}

class FakeRegisterRequest extends Fake implements RegisterRequest {}

class FakeRefreshRequest extends Fake implements RefreshRequest {}

void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );

    registerFallbackValue<LoginRequest>(FakeLoginRequest());
    registerFallbackValue<RegisterRequest>(FakeRegisterRequest());
    registerFallbackValue<RefreshRequest>(FakeRefreshRequest());
  });
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  final tId = 1;
  final tUsername = 'user';
  final tEmail = 'user@user.com';
  final tPassword = 'user123';
  final tErrorMessage = 'Fail';

  final tLoginRequest = LoginRequest(username: tUsername, password: tPassword);

  final tRegisterRequest =
      RegisterRequest(username: tUsername, email: tEmail, password: tPassword);

  final tTokenModel = TokenModel(access: '123', refresh: '321');

  final tToken = tTokenModel;

  final tUserModel = UserModel(id: tId, username: tUsername, email: tEmail);

  final tUser = tUserModel;

  group('login user', () {
    setUp(() {
      when(() => mockLocalDataSource.cacheToken(tTokenModel))
          .thenAnswer((_) async => {});

      when(() => mockRemoteDataSource.loginUser(tLoginRequest))
          .thenAnswer((_) async => tTokenModel);
    });

    test('should check if the device is online', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      await repository.loginUser(tLoginRequest);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return the token when the remote call is successful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.loginUser(any()))
              .thenAnswer((_) async => tTokenModel);

          // Act
          final result = await repository.loginUser(tLoginRequest);

          // Verify that the method has been called on the Repository
          verify(() => mockRemoteDataSource.loginUser(tLoginRequest));

          // Assert
          expect(result, equals(Right(tToken)));
        },
      );

      test(
        'should cache the token locally when the remote call is successful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.loginUser(any()))
              .thenAnswer((_) async => tTokenModel);

          // Act
          await repository.loginUser(tLoginRequest);

          // Assert
          verify(() => mockRemoteDataSource.loginUser(tLoginRequest));

          verify(() => mockLocalDataSource.cacheToken(tTokenModel));
        },
      );

      test(
        'should return server failure when the remote call is unsuccessful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.loginUser(any()))
              .thenThrow(ServerException(message: tErrorMessage));

          // Act
          final result = await repository.loginUser(tLoginRequest);

          // Assert
          verify(() => mockRemoteDataSource.loginUser(tLoginRequest));

          verifyZeroInteractions(mockLocalDataSource);

          expect(result, equals(Left(ServerFailure(message: tErrorMessage))));
        },
      );
    });

    runTestsOffline(() {
      test('should return network failure if the device is offline', () async {
        // Arrange
        when(() => mockRemoteDataSource.loginUser(tLoginRequest))
            .thenAnswer((_) async => tTokenModel);

        // Act
        final result = await repository.loginUser(tLoginRequest);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('register user', () {
    setUp(() {
      when(() => mockRemoteDataSource.registerUser(tRegisterRequest))
          .thenAnswer((_) async => tUserModel);
    });

    test('should check if the device is online', () {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      repository.registerUser(tRegisterRequest);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return the user when the remote call is successful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.registerUser(any()))
              .thenAnswer((_) async => tUserModel);

          // Act
          final result = await repository.registerUser(tRegisterRequest);

          // Verify that the method has been called on the Repository
          verify(() => mockRemoteDataSource.registerUser(tRegisterRequest));

          // Assert
          expect(result, equals(Right(tUser)));
        },
      );

      test(
        'should return server failure when the remote call is unsuccessful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.registerUser(any()))
              .thenThrow(ServerException(message: tErrorMessage));

          // Act
          final result = await repository.registerUser(tRegisterRequest);

          // Assert
          verify(() => mockRemoteDataSource.registerUser(tRegisterRequest));

          verifyZeroInteractions(mockLocalDataSource);

          expect(result, equals(Left(ServerFailure(message: tErrorMessage))));
        },
      );
    });

    runTestsOffline(() {
      test('should return a no connection failure if the device is offline',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.registerUser(tRegisterRequest))
            .thenAnswer((_) async => tUserModel);

        // Act
        final result = await repository.registerUser(tRegisterRequest);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('fetch token', () {
    test('should return last locally cached data when cached data is present',
        () async {
      // Arrange
      when(() => mockLocalDataSource.fetchToken())
          .thenAnswer((_) async => tTokenModel);

      // Act
      final result = await repository.fetchToken();

      // Assert
      verifyZeroInteractions(mockRemoteDataSource);

      verify(() => mockLocalDataSource.fetchToken());

      expect(result, equals(Right(tToken)));
    });

    test('should return cache failure when cached data is not present',
        () async {
      // Arrange
      when(() => mockLocalDataSource.fetchToken()).thenThrow(CacheException());

      // Act
      final result = await repository.fetchToken();

      // Assert
      verifyZeroInteractions(mockRemoteDataSource);

      verify(() => mockLocalDataSource.fetchToken());

      expect(result, equals(Left(CacheFailure())));
    });
  });
}
