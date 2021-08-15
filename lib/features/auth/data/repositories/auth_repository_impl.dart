import 'package:capybara_app/core/errors/exceptions/cache_exception.dart';
import 'package:capybara_app/core/errors/failures/cache_failure.dart';
import 'package:capybara_app/core/network/network_info.dart';
import 'package:capybara_app/core/errors/exceptions/server_exception.dart';
import 'package:capybara_app/core/errors/failures/no_connection_failure.dart';
import 'package:capybara_app/core/errors/failures/server_failure.dart';
import 'package:capybara_app/features/auth/data/datasource/auth_local_data_source.dart';
import 'package:capybara_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/features/auth/data/models/token_model.dart';
import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:capybara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

typedef Future<TokenModel> _Authenticate();

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
    return await this._getRemoteData(
      () => this.remoteDataSource.loginUser(username, password),
    );
  }

  @override
  Future<Either<Failure, Token>> registerUser(
    String username,
    String email,
    String password,
  ) async {
    return await this._getRemoteData(
      () => this.remoteDataSource.registerUser(username, email, password),
    );
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

  Future<Either<Failure, Token>> _getRemoteData(
      _Authenticate authenticate) async {
    if (!await this.networkInfo.isConnected) {
      return Left(NoConnectionFailure());
    }

    try {
      final remoteData = await authenticate();
      this.localDataSource.cacheToken(remoteData);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
