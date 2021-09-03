import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/channel/channel_local_data_source.dart';
import 'package:capybara_app/data/datasource/channel/channel_remote_data_source.dart';
import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/data/models/channel/channel_model.dart';
import 'package:capybara_app/data/repositories/channel_repository_impl.dart';
import 'package:capybara_app/data/requests/channel/add_to_channel_request.dart';
import 'package:capybara_app/data/requests/channel/channel_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements ChannelRemoteDataSource {}

class MockLocalDataSource extends Mock implements ChannelLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class FakeAddToChannelRequest extends Fake implements AddToChannelRequest {}

class FakeChannelRequest extends Fake implements ChannelRequest {}

main() {
  late ChannelRespositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ChannelRespositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
    registerFallbackValue<ChannelRequest>(FakeChannelRequest());
    registerFallbackValue<AddToChannelRequest>(FakeAddToChannelRequest());
  });

  const String channelNameFirst = 'somebody';
  const String channelNameSecond = 'once';
  const String channelId = '1';
  const String userId = '1';
  final tErrorMessage = 'Fail';
  List<ChannelModel> channels = [];
  final users = List.generate(
      4,
      (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));
  final tChannelRequest = ChannelRequest(name: channelNameFirst, users: users);
  final tAddToChannelRequest =
      AddToChannelRequest(channelId: channelId, userId: userId);
  channels.add(ChannelModel(
      name: channelNameFirst, users: users.getRange(0, 2).toList()));
  channels.add(ChannelModel(
      name: channelNameSecond, users: users.getRange(0, 2).toList()));

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
            .thenThrow(ServerException(message: tErrorMessage));

        //act
        final result = await repository.fetchChannels();

        //assert
        verify(() => mockRemoteDataSource.fetchChannels());

        verifyZeroInteractions(mockLocalDataSource);

        expect(result, Left(ServerFailure(message: tErrorMessage)));
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
      when(() => mockRemoteDataSource.createChannel(any()))
          .thenAnswer((_) async => channels.first);
    });
    test('should check connection', () async {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      await repository.createChannel(tChannelRequest);

      //assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device if online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return channel if remote call was successful', () async {
        when(() => mockRemoteDataSource.createChannel(any()))
            .thenAnswer((_) async => channels.first);
        //Act
        final result = await repository.createChannel(tChannelRequest);

        // Assert
        verify(() => mockRemoteDataSource.createChannel(tChannelRequest));

        expect(result, Right(channels.first));
      });
      test('should throw ServerFailure when remote call failed', () async {
        //Arrange
        when(() => mockRemoteDataSource.createChannel(any()))
            .thenThrow(ServerException(message: tErrorMessage));
        //Act

        final result = await repository.createChannel(tChannelRequest);

        //Assert
        expect(result, Left(ServerFailure(message: tErrorMessage)));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should throw no connection failure', () async {
        //Act
        final result = await repository.createChannel(tChannelRequest);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });
  group('add to channel', () {
    setUp(() {
      when(() => mockRemoteDataSource.addToChannel(any()))
          .thenAnswer((_) async => unit);
    });
    test('should check connection', () {
      //arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository.addToChannel(tAddToChannelRequest);

      //assert
      verify(() => mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should add to channel', () async {
        //Arrange
        when(() => mockRemoteDataSource.addToChannel(any()))
            .thenAnswer((_) async => unit);

        //Act
        final result = await repository.addToChannel(tAddToChannelRequest);

        //Assert
        verify(() => mockRemoteDataSource.addToChannel(tAddToChannelRequest));

        expect(result, Right(unit));
      });
      test('should throw failure when server issue', () async {
        //Arrange
        when(() => mockRemoteDataSource.addToChannel(any()))
            .thenThrow(ServerException(message: tErrorMessage));

        //Act
        final result = await repository.addToChannel(tAddToChannelRequest);

        //Assert
        verify(() => mockRemoteDataSource.addToChannel(tAddToChannelRequest));

        expect(result, Left(ServerFailure(message: tErrorMessage)));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should throw no connection failure', () async {
        //Act
        final result = await repository.addToChannel(tAddToChannelRequest);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);

        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
