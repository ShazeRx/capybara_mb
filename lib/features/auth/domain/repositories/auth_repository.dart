import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> loginUser(String username, String password);

  Future<Either<Failure, Token>> registerUser(
    String email,
    String password,
    String username,
  );

  Future<Either<Failure, Token>> fetchToken();
}
