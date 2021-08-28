import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;

  LogoutUser({
    required AuthRepository authRepository,
  }) : this._authRepository = authRepository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await this._authRepository.logoutUser();
  }
}
