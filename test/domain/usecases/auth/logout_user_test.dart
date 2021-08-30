import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/auth/logout_user.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogoutUser usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LogoutUser(
      authRepository: mockAuthRepository,
    );
  });

  test('should call logout in auth repository', () async {
    // Arrange
    when(() => mockAuthRepository.logoutUser())
        .thenAnswer((_) async => Right(unit));

    // Act
    await usecase(NoParams());

    // Assert
    verify(() => mockAuthRepository.logoutUser());

    verifyNoMoreInteractions(mockAuthRepository);
  });
}
