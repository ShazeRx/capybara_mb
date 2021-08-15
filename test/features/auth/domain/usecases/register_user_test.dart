import 'package:capybara_app/features/auth/domain/entities/token.dart';
import 'package:capybara_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:capybara_app/features/auth/domain/usecases/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterUser usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterUser(authRepository: mockAuthRepository);
  });

  final tUsername = '';
  final tEmail = '';
  final tPassword = '';
  final Token tToken = Token(access: '123', refresh: '321');

  test('should get a token from the repository', () async {
    // Arrange
    // When registerUser is called with any arguments, always answer with
    // the Right "side" of Either containing a test Token object.
    when(() => mockAuthRepository.registerUser(any(), any(), any()))
        .thenAnswer((_) async => Right(tToken));

    // Act
    final result = await usecase(
      RegisterParams(
        username: tUsername,
        email: tEmail,
        password: tPassword,
      ),
    );

    // Assert
    expect(result, Right(tToken));

    // Verify that the method has been called on the Repository
    verify(() => mockAuthRepository.registerUser(tUsername, tEmail, tPassword));

    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
