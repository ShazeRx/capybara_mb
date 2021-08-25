import 'package:capybara_app/domain/entities/user.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/auth/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeRegisterParams extends Fake implements RegisterParams {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterUser usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterUser(authRepository: mockAuthRepository);
    registerFallbackValue<RegisterParams>(FakeRegisterParams());
  });

  final tUsername = 'user';
  final tEmail = 'user@user.com';
  final tPassword = 'user123';
  final tUser = User(email: tEmail, username: tUsername);
  final tRegisterParams =
      RegisterParams(username: tUsername, email: tEmail, password: tPassword);

  test('should return registered user', () async {
    // Arrange
    // When registerUser is called with any arguments, always answer with
    // the Right "side" of Either containing a test User object.
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => Right(tUser));

    // Act
    final result = await usecase(
      RegisterParams(
        username: tUsername,
        email: tEmail,
        password: tPassword,
      ),
    );

    // Assert
    expect(result, Right(tUser));

    // Verify that the method has been called on the Repository
    verify(() => mockAuthRepository.registerUser(tRegisterParams));

    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
