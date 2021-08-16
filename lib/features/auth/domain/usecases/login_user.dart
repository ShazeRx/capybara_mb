import 'package:capybara_app/core/usecases/usecase.dart';
import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:capybara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:equatable/equatable.dart';

class LoginUser implements UseCase<Token, LoginParams> {
  final AuthRepository authRepository;

  LoginUser({required this.authRepository});

  @override
  Future<Either<Failure, Token>> call(LoginParams params) async {
    return await this
        .authRepository
        .loginUser(params.username, params.password);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}
