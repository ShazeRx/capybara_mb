import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/chat_local_data_source.dart';
import 'package:capybara_app/data/datasource/chat_remote_data_source.dart';
import 'package:capybara_app/domain/entities/message.dart';
import 'package:capybara_app/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Message>>> fetchLast10Messages() async {
    if (await networkInfo.isConnected) {
      try {
        final messages = await remoteDataSource.fetchLast10Messages();
        localDataSource.cacheMessages(messages);
        return Right(messages);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    try {
      final messages = await localDataSource.fetchLast10Messages();
      return Right(messages);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Message>>> fetchLast10MessagesFromTimestamp(
      String timestamp) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
            await remoteDataSource.fetchLast10MessagesFromTimestamp(timestamp));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NoConnectionFailure());
  }

  @override
  Future<Either<Failure, void>> sendMessage(String body) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.sendMessage(body));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NoConnectionFailure());
  }
}
