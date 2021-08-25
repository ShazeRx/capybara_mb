import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:dartz/dartz.dart';

extension EitherResult<T> on Either<Failure, T> {
  T? getValueOrNull<T>() {
    T? result;
    this.fold(
      (failure) => null,
      (value) => result = cast<T>(value),
    );
    return result;
  }

  Failure? getFailureOrNull() {
    Failure? result;
    this.fold(
      (failure) => result = failure,
      (value) => null,
    );
    return result;
  }
}
