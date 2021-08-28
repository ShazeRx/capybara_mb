import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';

class FetchToken implements UseCase<Token, NoParams> {
  final AuthRepository _authRepository;

  FetchToken({
    required AuthRepository authRepository,
  }) : this._authRepository = authRepository;

  @override
  Future<Either<Failure, Token>> call(NoParams params) async {
    return await this._authRepository.fetchToken();
  }
}
