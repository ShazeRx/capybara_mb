import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/chat/chat_local_data_source.dart';
import 'package:capybara_app/data/datasource/chat/chat_remote_data_source.dart';
import 'package:capybara_app/domain/entities/chat/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource _localDataSource;
  final ChatRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ChatRepositoryImpl(
      {required ChatLocalDataSource localDataSource,
      required ChatRemoteDataSource remoteDataSource,
      required NetworkInfo networkInfo}): this._localDataSource = localDataSource,
        this._remoteDataSource = remoteDataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Message>>> fetchLast10Messages() async {
    if (await _networkInfo.isConnected) {
      try {
        final messages = await _remoteDataSource.fetchLast10Messages();
        _localDataSource.cacheMessages(messages);
        return Right(messages);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }
    try {
      final messages = await _localDataSource.fetchLast10Messages();
      return Right(messages);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Message>>> fetchLast10MessagesFromTimestamp(
      String timestamp) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(
            await _remoteDataSource.fetchLast10MessagesFromTimestamp(timestamp));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, void>> sendMessage(String body) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _remoteDataSource.sendMessage(body));
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    }
    return Left(NetworkFailure());
  }
}
