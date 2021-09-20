import 'package:capybara_app/data/models/auth/user_model.dart';
import 'package:capybara_app/ui/states/user/users_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UsersStateImpl usersStateImpl;

  setUp(() {
    usersStateImpl = UsersStateImpl();
  });
  final users = List.generate(
      4,
      (index) => UserModel(
          id: index, username: 'some$index', email: 'some$index@body.pl'));

  group('set users', () {
    test('should set users', () {
      //Arrange
      usersStateImpl.setUsers(users);

      //Act
      final result = usersStateImpl.users$.value;

      //Assert
      expect(result, users);
    });
  });
}
