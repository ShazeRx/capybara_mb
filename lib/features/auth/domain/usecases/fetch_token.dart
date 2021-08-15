import 'package:capybara_app/core/usecases/usecase.dart';
import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:capybara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:equatable/equatable.dart';

class FetchToken extends UseCase<Token, NoParams> {
  final AuthRepository authRepository;

  FetchToken({required this.authRepository});

  @override
  Future<Either<Failure, Token>> call(NoParams params) async {
    return await this.authRepository.fetchToken();
  }
}
