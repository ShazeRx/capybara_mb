import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/repositories/auth_repository.dart';
import 'package:capybara_app/domain/usecases/fetch_token.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late FetchToken usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = FetchToken(authRepository: mockAuthRepository);
  });


  final Token tToken = Token(access: '123', refresh: '321');

  test('should return cached token if available', () async {
    // Arrange
    when(() => mockAuthRepository.fetchToken())
        .thenAnswer((_) async => Right(tToken));

    // Act
    final result = await usecase(NoParams());

    // Assert
    verify(() => mockAuthRepository.fetchToken());

    verifyNoMoreInteractions(mockAuthRepository);

    expect(result, Right(tToken));
  });
}
