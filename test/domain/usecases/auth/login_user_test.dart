import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/auth/login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUser usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUser(authRepository: mockAuthRepository);

    registerFallbackValue<LoginParams>(FakeLoginParams());
  });

  final tUsername = 'user';
  final tPassword = 'user123';
  final Token tToken = Token(access: '123', refresh: '321');
  final tLoginParams = LoginParams(username: tUsername, password: tPassword);

  test('should get a token from the repository', () async {
    // Arrange
    // When loginUser is called with any arguments, always answer with
    // the Right "side" of Either containing a test Token object.
    when(() => mockAuthRepository.loginUser(any()))
        .thenAnswer((_) async => Right(tToken));

    // Act
    final result = await usecase(
      LoginParams(
        username: tUsername,
        password: tPassword,
      ),
    );

    // Assert
    expect(result, Right(tToken));

    // Verify that the method has been called on the Repository
    verify(() => mockAuthRepository.loginUser(tLoginParams));

    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
