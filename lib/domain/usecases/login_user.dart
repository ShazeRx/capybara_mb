import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:equatable/equatable.dart';

class LoginUser implements UseCase<Token, LoginParams> {
  final AuthRepository _authRepository;

  LoginUser({
    required authRepository,
  }) : this._authRepository = authRepository;

  @override
  Future<Either<Failure, Token>> call(LoginParams params) async {
    return await this._authRepository.loginUser(
          params.username,
          params.password,
        );
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}
