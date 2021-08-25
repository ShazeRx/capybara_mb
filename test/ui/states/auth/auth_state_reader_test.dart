import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:capybara_app/ui/states/auth/auth_state_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

class MockAuthState extends Mock implements AuthState {}

void main() {
  late MockAuthState mockAuthState;
  late AuthStateReader authStateReader;
  final tToken = Token(access: '123', refresh: '321');
  final tUser = User(username: 'user', email: 'user@user.com');

  mockTokenSubject() {
    when(() => mockAuthState.token$)
        .thenAnswer((_) => BehaviorSubject<Token?>.seeded(tToken));
  }

  mockUserObject() {
    when(() => mockAuthState.user$)
        .thenAnswer((_) => BehaviorSubject<User?>.seeded(tUser));
  }

  setUp(() {
    mockAuthState = MockAuthState();
    mockTokenSubject();
    mockUserObject();

    authStateReader = AuthStateReader(authState: mockAuthState);
  });

  test('should get new value of token', () async {
    // Act
    final result = authStateReader.token;

    // Assert
    expect(result, tToken);
  });

  test('should get new value of user', () async {
    // Act
    final result = authStateReader.user;

    // Assert
    expect(result, tUser);
  });
}
