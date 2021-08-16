import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/usecases/usecase.dart';
import 'package:capybara_app/features/auth/domain/entities/user.dart';
import 'package:capybara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUser implements UseCase<User, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUser({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await this
        .authRepository
        .registerUser(params.username, params.email, params.password);
  }
}

class RegisterParams extends Equatable {
  final String username;
  final String email;
  final String password;

  RegisterParams({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [this.username, this.email, this.password];
}
