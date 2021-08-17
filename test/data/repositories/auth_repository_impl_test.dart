import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/data/datasource/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth_remote_data_source.dart';
import 'package:capybara_app/data/models/token_model.dart';
import 'package:capybara_app/data/models/user_model.dart';
import 'package:capybara_app/data/repositories/auth_repository_impl.dart';
import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

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

  final tUsername = 'admin';
  final tEmail = 'admin@admin.com';
  final tPassword = 'admin';
  final TokenModel tTokenModel = TokenModel(access: '123', refresh: '321');
  final Token tToken = tTokenModel;
  final UserModel tUserModel = UserModel(username: 'user', email: 'user@user.com');
  final User tUser = tUserModel;

  group('login user', () {
    setUp(() {
      when(() => mockLocalDataSource.cacheToken(tTokenModel))
          .thenAnswer((_) async => {});

      when(() => mockRemoteDataSource.loginUser(tUsername, tPassword))
          .thenAnswer((_) async => tTokenModel);
    });

    test('should check if the device is online', () {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      repository.loginUser(tUsername, tPassword);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return the token when the remote call is successful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.loginUser(any(), any()))
              .thenAnswer((_) async => tTokenModel);

          // Act
          final result = await repository.loginUser(tUsername, tPassword);

          // Verify that the method has been called on the Repository
          verify(() => mockRemoteDataSource.loginUser(tUsername, tPassword));

          // Assert
          expect(result, equals(Right(tToken)));
        },
      );

      test(
        'should cache the token locally when the remote call is successful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.loginUser(any(), any()))
              .thenAnswer((_) async => tTokenModel);

          // Act
          await repository.loginUser(tUsername, tPassword);

          // Assert
          verify(() => mockRemoteDataSource.loginUser(tUsername, tPassword));

          verify(() => mockLocalDataSource.cacheToken(tTokenModel));
        },
      );

      test(
        'should return server failure when the remote call is unsuccessful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.loginUser(any(), any()))
              .thenThrow(ServerException());

          // Act
          final result = await repository.loginUser(tUsername, tPassword);

          // Assert
          verify(() => mockRemoteDataSource.loginUser(tUsername, tPassword));

          verifyZeroInteractions(mockLocalDataSource);

          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test('should return a no connection failure if the device is offline',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.loginUser(tUsername, tPassword))
            .thenAnswer((_) async => tTokenModel);

        // Act
        final result = await repository.loginUser(tUsername, tPassword);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, equals(Left(NoConnectionFailure())));
      });
    });
  });

  group('register user', () {
    setUp(() {
      when(() => mockLocalDataSource.cacheToken(tTokenModel))
          .thenAnswer((_) async => {});

      when(() =>
              mockRemoteDataSource.registerUser(tUsername, tEmail, tPassword))
          .thenAnswer((_) async => tUserModel);
    });

    test('should check if the device is online', () {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      // Act
      repository.registerUser(tUsername, tEmail, tPassword);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return the user when the remote call is successful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.registerUser(any(), any(), any()))
              .thenAnswer((_) async => tUserModel);

          // Act
          final result = await repository.registerUser(tUsername, tEmail, tPassword);

          // Verify that the method has been called on the Repository
          verify(() => mockRemoteDataSource.registerUser(tUsername, tEmail, tPassword));

          // Assert
          expect(result, equals(Right(tUser)));
        },
      );

      test(
        'should return server failure when the remote call is unsuccessful',
        () async {
          // Arrange
          when(() => mockRemoteDataSource.registerUser(any(), any(), any()))
              .thenThrow(ServerException());

          // Act
          final result =
              await repository.registerUser(tUsername, tEmail, tPassword);

          // Assert
          verify(() =>
              mockRemoteDataSource.registerUser(tUsername, tEmail, tPassword));

          verifyZeroInteractions(mockLocalDataSource);

          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test('should return a no connection failure if the device is offline',
          () async {
        // Arrange
        when(() =>
                mockRemoteDataSource.registerUser(tUsername, tEmail, tPassword))
            .thenAnswer((_) async => tUserModel);

        // Act
        final result =
            await repository.registerUser(tUsername, tEmail, tPassword);

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, equals(Left(NoConnectionFailure())));
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
      when(() => mockLocalDataSource.fetchToken())
          .thenThrow(CacheException());

      // Act
      final result = await repository.fetchToken();

      // Assert
      verifyZeroInteractions(mockRemoteDataSource);

      verify(() => mockLocalDataSource.fetchToken());

      expect(result, equals(Left(CacheFailure())));
    });
  });
}
