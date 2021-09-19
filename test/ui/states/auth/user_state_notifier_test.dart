import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/states/auth/user_state.dart';
import 'package:capybara_app/ui/states/auth/user_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

class MockUserState extends Mock implements UserState {}

void main() {
  late MockUserState mockUserState;
  late UserStateNotifier userStateNotifier;
  final tUser = User(id: 1, email: 'user@user.com', username: 'user');

  mockUserObject() {
    when(() => mockUserState.user$)
        .thenAnswer((_) => BehaviorSubject<User?>.seeded(tUser));
  }

  setUp(() {
    mockUserState = MockUserState();
    mockUserObject();

    userStateNotifier = UserStateNotifier(userState: mockUserState);
  });

  test('should get new value of user', () async {
    // Act
    final result = userStateNotifier.user;

    // Assert
    expect(result, tUser);
  });
}
