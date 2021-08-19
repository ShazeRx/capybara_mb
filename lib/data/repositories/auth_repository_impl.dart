import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';

import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/data/datasource/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth_remote_data_source.dart';
import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required remoteDataSource,
    required localDataSource,
    required networkInfo,
  })  : this._remoteDataSource = remoteDataSource,
        this._localDataSource = localDataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, Token>> loginUser(
    String username,
    String password,
  ) async {
    if (!await this._networkInfo.isConnected) {
      return Left(NoConnectionFailure());
    }
    try {
      final token = await this._remoteDataSource.loginUser(username, password);
      this._localDataSource.cacheToken(token);
      return Right(token);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(
    String username,
    String email,
    String password,
  ) async {
    if (!await this._networkInfo.isConnected) {
      return Left(NoConnectionFailure());
    }
    try {
      final user =
          await this._remoteDataSource.registerUser(username, email, password);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> fetchToken() async {
    try {
      final token = await this._localDataSource.fetchToken();
      return Right(token);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
