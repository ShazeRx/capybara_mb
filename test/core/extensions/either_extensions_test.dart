import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/errors/failures/network_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/core/extensions/either_extensions.dart';

main() {
  final tValue = 'test';
  final tFailure = NetworkFailure();

  group('get value or null', () {
    test('should return value from either when result is right', () {
      // Arrange
      Either<Failure, String> either = Right(tValue);

      // Act
      final result = either.getValueOrNull<String>();

      // Assert
      expect(result, tValue);
    });

    test('should return null from either when result is left', () {
      // Arrange
      Either<Failure, String> either = Left(tFailure);

      // Act
      final result = either.getValueOrNull<String>();

      // Assert
      expect(result, null);
    });
  });

  group('get failure or null', () {
    test('should return failure from either when result is left', () {
      // Arrange
      Either<Failure, String> either = Left(tFailure);

      // Act
      final result = either.getFailureOrNull();

      // Assert
      expect(result, tFailure);
    });

    test('should return null from either when result is right', () {
      // Arrange
      Either<Failure, String> either = Right(tValue);

      // Act
      final result = either.getFailureOrNull();

      // Assert
      expect(result, null);
    });
  });
}
