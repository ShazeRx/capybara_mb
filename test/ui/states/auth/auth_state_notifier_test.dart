import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:capybara_app/ui/states/auth/auth_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

class MockAuthState extends Mock implements AuthState {}

void main() {
  late MockAuthState mockAuthState;
  late AuthStateNotifier authStateReader;
  final tToken = Token(access: '123', refresh: '321');
  final tUser = User(id: 1, email: 'user@user.com', username: 'user');

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

    authStateReader = AuthStateNotifier(authState: mockAuthState);
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
