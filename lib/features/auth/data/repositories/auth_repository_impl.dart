import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:capybara_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:capybara_app/features/auth/domain/entities/user.dart';
import 'package:capybara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Token>> loginUser(
    String username,
    String password,
  ) async {
    if (!await this.networkInfo.isConnected) {
      return Left(NoConnectionFailure());
    }
    try {
      final token = await this.remoteDataSource.loginUser(username, password);
      this.localDataSource.cacheToken(token);
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
    if (!await this.networkInfo.isConnected) {
      return Left(NoConnectionFailure());
    }
    try {
      final user =
          await this.remoteDataSource.registerUser(username, email, password);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> fetchToken() async {
    try {
      final token = await this.localDataSource.fetchToken();
      return Right(token);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
