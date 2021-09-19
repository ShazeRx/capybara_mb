import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TokenStateImpl tokenState;

  setUp(() {
    tokenState = TokenStateImpl();
  });

  final tToken = Token(access: '123', refresh: '321');

  group('set token', () {
    test('should emit new value of token', () {
      // Arrange
      tokenState.setToken(tToken);

      // Act
      final result = tokenState.token$.value;

      // Assert
      expect(result, tToken);
    });
  });
}
