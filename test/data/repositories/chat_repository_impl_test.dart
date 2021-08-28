import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/chat/chat_local_data_source.dart';
import 'package:capybara_app/data/datasource/chat/chat_remote_data_source.dart';
import 'package:capybara_app/data/repositories/chat_repository_impl.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements ChatRemoteDataSource {}

class MockLocalDataSource extends Mock implements ChatLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ChatRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  final List<Message> messages = [];
  final messageBody = 'some';
  final timestamp = '21.01.2021';
  messages
      .add(new Message('21.01.2021', message: messageBody, username: 'body'));
  messages.add(new Message('22.01.2021', message: 'once', username: 'told'));
  final tErrorMessage = 'Fail';
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ChatRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('fetch last 10 messages', () {
    setUp(() {
      when(() => mockRemoteDataSource.fetchLast10Messages())
          .thenAnswer((_) async => messages);
      when(() => mockLocalDataSource.cacheMessages(any()))
          .thenAnswer((_) async => null);
    });
    test('should check network connection', () async {
      //Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //Act
      await repository.fetchLast10Messages();

      //Assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return messages', () async {
        //Act
        final result = await repository.fetchLast10Messages();

        //Assert
        verify(() => mockRemoteDataSource.fetchLast10Messages());

        expect(result, Right(messages));
      });
      test('should return server failure when call was unsuccesfull', () async {
        //Arrange
        when(() => mockRemoteDataSource.fetchLast10Messages())
            .thenThrow(ServerException(message: tErrorMessage));

        //Act
        final result = await repository.fetchLast10Messages();

        //Assert
        verifyZeroInteractions(mockLocalDataSource);

        expect(result, Left(ServerFailure(message: tErrorMessage)));
      });
      test('should cache results', () async {
        //Arrange
        when(() => mockLocalDataSource.cacheMessages(any()))
            .thenAnswer((_) async => null);

        //Act
        await repository.fetchLast10Messages();

        //Assert
        verify(() => mockLocalDataSource.cacheMessages(messages));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached when not connected', () async {
        //Arrange
        when(() => mockLocalDataSource.fetchLast10Messages())
            .thenAnswer((_) async => messages);

        //Act
        final result = await repository.fetchLast10Messages();

        //Assert
        verify(() => mockLocalDataSource.fetchLast10Messages());

        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Right(messages));
      });
      test('should throw cache failure when not available', () async {
        //Arrange
        when(() => mockLocalDataSource.fetchLast10Messages())
            .thenThrow(CacheException());

        //Act
        final result = await repository.fetchLast10Messages();

        //Assert
        verify(() => mockLocalDataSource.fetchLast10Messages());

        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Left(CacheFailure()));
      });
    });
  });
  group('fetch last 10 messages from timestamp ', () {
    setUp(() {
      when(() => mockRemoteDataSource.fetchLast10MessagesFromTimestamp(any()))
          .thenAnswer((_) async => messages);
    });
    test('should check network connection', () async {
      //Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //Act
      await repository.fetchLast10MessagesFromTimestamp(timestamp);

      //Assert

      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockRemoteDataSource.fetchLast10MessagesFromTimestamp(any()))
            .thenAnswer((_) async => messages);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return messages', () async {
        //Act
        final result =
            await repository.fetchLast10MessagesFromTimestamp(timestamp);

        //Assert
        verify(() =>
            mockRemoteDataSource.fetchLast10MessagesFromTimestamp(timestamp));
        expect(result, Right(messages));
      });
      test('should return server failure when call was unsuccessful', () async {
        //Arrange
        when(() => mockRemoteDataSource.fetchLast10MessagesFromTimestamp(any()))
            .thenThrow(ServerException(message: tErrorMessage));

        //Act
        final result =
            await repository.fetchLast10MessagesFromTimestamp(timestamp);

        //Assert
        verifyZeroInteractions(mockLocalDataSource);

        expect(result, Left(ServerFailure(message: tErrorMessage)));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should throw no connection failure', () async {
        //Act
        final result =
            await repository.fetchLast10MessagesFromTimestamp(timestamp);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Left(NetworkFailure()));
      });
    });
  });
  group('sendMessage', () {
    test('should check network connection', () async {
      //Arrange
      when(() => mockRemoteDataSource.sendMessage(any()))
          .thenAnswer((_) async => null);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //Act
      await repository.sendMessage(messageBody);

      //Assert

      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should send message', () async {
        //Arrange
        when(() => mockRemoteDataSource.sendMessage(messageBody))
            .thenAnswer((_) async => null);

        //Act
        final result = await repository.sendMessage(messageBody);

        //Arrange
        verify(() => mockRemoteDataSource.sendMessage(messageBody));

        expect(result, Right(null));
      });
      test('should throw Server Failure when call was unsuccessful', () async {
        //Arrange
        when(() => mockRemoteDataSource.sendMessage(any()))
            .thenThrow(ServerException(message: tErrorMessage));

        //Act
        final result = await repository.sendMessage(messageBody);

        //Assert
        verify(() => mockRemoteDataSource.sendMessage(messageBody));

        expect(result, Left(ServerFailure(message: tErrorMessage)));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should throw no connection failure', () async {
        //Act
        final result = await repository.sendMessage(messageBody);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
