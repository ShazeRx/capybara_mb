import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/channel/channel_local_data_source.dart';
import 'package:capybara_app/data/datasource/channel/channel_remote_data_source.dart';
import 'package:capybara_app/data/requests/channel/add_to_channel_request.dart';
import 'package:capybara_app/data/requests/channel/channel_request.dart';
import 'package:capybara_app/domain/entities/channel/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:capybara_app/domain/usecases/channel/add_to_channel.dart';
import 'package:capybara_app/domain/usecases/channel/create_channel.dart';
import 'package:dartz/dartz.dart';

class ChannelRespositoryImpl implements ChannelRepository {
  final ChannelLocalDataSource _localDataSource;
  final ChannelRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ChannelRespositoryImpl(
      {required ChannelLocalDataSource localDataSource,
      required ChannelRemoteDataSource remoteDataSource,
      required NetworkInfo networkInfo})
      : this._localDataSource = localDataSource,
        this._remoteDataSource = remoteDataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, Unit>> addToChannel(AddToChannelParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final result =await _remoteDataSource
            .addToChannel(AddToChannelRequest.fromParams(params));
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, Channel>> createChannel(ChannelParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final channel = await _remoteDataSource
            .createChannel(ChannelRequest.fromParams(params));
        return Right(channel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<Channel>>> fetchChannels() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteChannels = await _remoteDataSource.fetchChannels();
        _localDataSource.cacheChannels(remoteChannels);
        return Right(remoteChannels);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final cacheChannels = await _localDataSource.fetchChannels();
        return Right(cacheChannels);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
