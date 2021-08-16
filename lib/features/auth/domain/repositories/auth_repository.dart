import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:capybara_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> loginUser(String username, String password);

  Future<Either<Failure, User>> registerUser(
    String username,
    String email,
    String password,
  );

  Future<Either<Failure, Token>> fetchToken();
}
