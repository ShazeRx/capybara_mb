import 'package:capybara_app/domain/entities/token.dart';
import 'package:capybara_app/domain/entities/user.dart';
import 'package:capybara_app/ui/states/auth/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthState authState;

  setUp(() {
    authState = AuthState();
  });

  final tToken = Token(access: '123', refresh: '321');
  final tUser = User(id: 1, email: 'user@user.com', username: 'user');

  group('set token', () {
    test('should emit new value of token', () {
      // Arrange
      authState.setToken(tToken);

      // Act
      final result = authState.token$.value;

      // Assert
      expect(result, tToken);
    });
  });

  group('set user', () {
    test('should emit new value of user', () {
      // Arrange
      authState.setUser(tUser);

      // Act
      final result = authState.user$.value;

      // Assert
      expect(result, tUser);
    });
  });
}
