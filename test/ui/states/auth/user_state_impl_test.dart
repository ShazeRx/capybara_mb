import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserStateImpl userState;

  setUp(() {
    userState = UserStateImpl();
  });

  final tUser = User(id: 1, email: 'user@user.com', username: 'user');

  group('set user', () {
    test('should emit new value of user', () {
      // Arrange
      userState.setUser(tUser);

      // Act
      final result = userState.user$.value;

      // Assert
      expect(result, tUser);
    });
  });
}
