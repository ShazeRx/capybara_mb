import 'package:capybara_app/core/constants/failure_messages.dart';
import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/exceptions/client_exception.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/errors/failures/client_failure.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/data/datasource/auth/auth_local_data_source.dart';
import 'package:capybara_app/data/datasource/auth/auth_remote_data_source.dart';
import 'package:capybara_app/data/requests/auth/login_request.dart';
import 'package:capybara_app/data/requests/auth/register_request.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';

import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : this._remoteDataSource = remoteDataSource,
        this._localDataSource = localDataSource,
        this._networkInfo = networkInfo;

  @override
  Future<Either<Failure, Tuple2<Token, User>>> loginUser(
      LoginParams params) async {
    if (!await this._networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final result = await this._remoteDataSource.loginUser(
            LoginRequest.fromParams(params),
          );

      this._localDataSource.cacheToken(result.value1);
      this._localDataSource.cacheUser(result.value2);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(RegisterParams params) async {
    if (!await this._networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final result = await this._remoteDataSource.registerUser(
            RegisterRequest.fromParams(params),
          );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ClientException catch (e) {
      return Left(ClientFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Token>> fetchToken() async {
    try {
      final result = await this._localDataSource.fetchToken();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logoutUser() async {
    try {
      final result = await this._localDataSource.removeToken();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure(message: FailureMessages.logoutFailure));
    }
  }
}
