import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/channel_local_data_source.dart';
import 'package:capybara_app/data/datasource/channel_remote_data_source.dart';
import 'package:capybara_app/data/models/channel_model.dart';
import 'package:capybara_app/data/repositories/channel_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements ChannelRemoteDataSource {}

class MockLocalDataSource extends Mock implements ChannelLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ChannelRespositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const String channelNameFirst = 'somebody';
  const String channelNameSecond = 'once';
  const String channelId = '1';
  const String userId = '1';
  List<ChannelModel> channels = [];
  channels.add(ChannelModel(name: channelNameFirst));
  channels.add(ChannelModel(name: channelNameSecond));
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ChannelRespositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('fetch channels', () {
    setUp(() {
      when(() => mockRemoteDataSource.fetchChannels())
          .thenAnswer((_) async => channels);
      when(() => mockLocalDataSource.cacheChannels(any()))
          .thenAnswer((_) async => channels);
    });
    test('should check if device is online', () {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository.fetchChannels();

      //assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        when(() => mockLocalDataSource.cacheChannels(any()))
            .thenAnswer((_) async => null);
      });
      test('should return remote data when connection is available', () async {
        //arrange
        when(() => mockRemoteDataSource.fetchChannels())
            .thenAnswer((_) async => channels);

        //act
        final result = await repository.fetchChannels();

        //assert
        verify(() => mockRemoteDataSource.fetchChannels());

        expect(result, Right(channels));
      });
      test('should cache response from remote', () async {
        //arrange
        when(() => mockRemoteDataSource.fetchChannels())
            .thenAnswer((_) async => channels);

        //act
        await repository.fetchChannels();

        //assert
        verify(() => mockRemoteDataSource.fetchChannels());
        verify(() => mockLocalDataSource.cacheChannels(channels));
      });
      test('should return server failure when call to remote was unsuccessful',
          () async {
        //arrange
        when(() => mockRemoteDataSource.fetchChannels())
            .thenThrow(ServerException());

        //act
        final result = await repository.fetchChannels();

        //assert
        verify(() => mockRemoteDataSource.fetchChannels());

        verifyZeroInteractions(mockLocalDataSource);

        expect(result, Left(ServerFailure()));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached results when is not connected to network',
          () async {
        //arrange
        when(() => mockLocalDataSource.fetchChannels())
            .thenAnswer((_) async => channels);

        //act
        final result = await repository.fetchChannels();

        //assert
        verify(() => mockLocalDataSource.fetchChannels());

        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Right(channels));
      });

      test('should return Cache Failure when cache not presented', () async {
        //arrange
        when(() => mockLocalDataSource.fetchChannels())
            .thenThrow(CacheException());

        //act
        final result = await repository.fetchChannels();

        //assert
        verify(() => mockLocalDataSource.fetchChannels());

        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Left(CacheFailure()));
      });
    });
  });
  group('create channel', () {
    setUp(() {
      when(() => mockRemoteDataSource.createChannel(channelNameFirst))
          .thenAnswer((_) async => channels.first);
    });
    test('should check connection', () {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository.createChannel(channelNameFirst);

      //assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device if online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return channel if remote call was successfull', () async {
        //Act
        final result = await repository.createChannel(channelNameFirst);

        //Assert
        verify(() => mockRemoteDataSource.createChannel(channelNameFirst));

        expect(result, Right(channels.first));
      });
      test('should throw ServerFailure when remote call failed', () async {
        //Arrange
        when(() => mockRemoteDataSource.createChannel(any()))
            .thenThrow(ServerException());
        //Act

        final result = await repository.createChannel(channelNameFirst);

        //Assert
        expect(result, Left(ServerFailure()));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should throw no connection failure', () async {
        //Act
        final result = await repository.createChannel(channelNameFirst);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, equals(Left(NoConnectionFailure())));
      });
    });
  });
  group('add to channel', () {
    setUp(() {
      when(() => mockRemoteDataSource.addToChannel(channelId, userId))
          .thenAnswer((_) async => channels.first);
    });
    test('should check connection', () {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository.addToChannel(channelId, userId);

      //assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should add to channel', () async {
        //Arrange
        when(() => mockRemoteDataSource.addToChannel(any(), any()))
            .thenAnswer((_) async => channels.first);

        //Act
        final result = await repository.addToChannel(channelId, userId);

        //Assert
        verify(() => mockRemoteDataSource.addToChannel(channelId, userId));

        expect(result, Right(channels.first));
      });
      test('should throw failure when server issue', () async {
        //Arrange
        when(() => mockRemoteDataSource.addToChannel(any(), any()))
            .thenThrow(ServerException());

        //Act
        final result = await repository.addToChannel(channelId, userId);

        //Assert
        verify(() => mockRemoteDataSource.addToChannel(channelId, userId));

        expect(result, Left(ServerFailure()));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should throw no connection failure', () async {
        //Act
        final result = await repository.addToChannel(channelId, userId);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Left(NoConnectionFailure()));
      });
    });
  });
}
