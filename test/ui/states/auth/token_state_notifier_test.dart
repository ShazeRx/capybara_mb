import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:capybara_app/ui/states/auth/token_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

class MockTokenState extends Mock implements TokenState {}

void main() {
  late MockTokenState mockTokenState;
  late TokenStateNotifier tokenStateNotifier;

  final tToken = Token(access: '123', refresh: '321');

  mockTokenSubject() {
    when(() => mockTokenState.token$)
        .thenAnswer((_) => BehaviorSubject<Token?>.seeded(tToken));
  }

  setUp(() {
    mockTokenState = MockTokenState();
    mockTokenSubject();

    tokenStateNotifier = TokenStateNotifier(tokenState: mockTokenState);
  });

  test('should get new value of token', () async {
    // Act
    final result = tokenStateNotifier.token;

    // Assert
    expect(result, tToken);
  });
}
