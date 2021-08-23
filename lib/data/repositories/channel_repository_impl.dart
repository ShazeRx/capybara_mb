import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/channel_local_data_source.dart';
import 'package:capybara_app/data/datasource/channel_remote_data_source.dart';
import 'package:capybara_app/domain/entities/channel.dart';
import 'package:capybara_app/domain/repositories/channel_repository.dart';
import 'package:dartz/dartz.dart';

class ChannelRespositoryImpl implements ChannelRepository {
  final ChannelLocalDataSource localDataSource;
  final ChannelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChannelRespositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Channel>> addToChannel(
      String channelId, String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final channel = await remoteDataSource.addToChannel(channelId, userId);
        return Right(channel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NoConnectionFailure());
  }

  @override
  Future<Either<Failure, Channel>> createChannel(String name) async {
    if (await networkInfo.isConnected) {
      try {
        final channel = await remoteDataSource.createChannel(name);
        return Right(channel);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NoConnectionFailure());
  }

  @override
  Future<Either<Failure, List<Channel>>> fetchChannels() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteChannels = await remoteDataSource.fetchChannels();
        localDataSource.cacheChannels(remoteChannels);
        return Right(remoteChannels);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheChannels = await localDataSource.fetchChannels();
        return Right(cacheChannels);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
