import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> loginUser(LoginParams params);

  Future<Either<Failure, User>> registerUser(RegisterParams params);

  Future<Either<Failure, Token>> fetchToken();
}
