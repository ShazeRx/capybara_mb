import 'package:capybara_app/core/constants/widget_keys.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/providers/register_provider.dart';
import 'package:capybara_app/ui/widgets/auth/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../setup/test_helpers.dart';

class MockRegisterProvider extends Mock implements RegisterProvider {}

void main() {
  late MockRegisterProvider mockRegisterProvider;
  setUp(() {
    mockRegisterProvider = MockRegisterProvider();
  });

  Future<void> pumpTestWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<RegisterProvider>.value(
        value: mockRegisterProvider,
        child: makeTestableWidgetWithScaffold(RegisterForm()),
      ),
    );
  }

  void mockProviderStateIdle() {
    when(() => mockRegisterProvider.state).thenReturn(ProviderState.idle);
  }

  testWidgets('create register form with empty username field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.registerUsername));
    final result =
        (username.evaluate().first.widget as TextFormField).initialValue;

    // Assert
    expect(result, '');
  });

  testWidgets('should enter username in form field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.registerUsername));
    await tester.enterText(username, 'user');

    // Assert
    expect(find.text('user'), findsOneWidget);
  });

  testWidgets('create register form with empty email field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.registerEmail));
    final result =
        (username.evaluate().first.widget as TextFormField).initialValue;

    // Assert
    expect(result, '');
  });

  testWidgets('should enter email in form field', (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final email = find.byKey(Key(WidgetKeys.registerEmail));
    await tester.enterText(email, 'user@user.com');

    // Assert
    expect(find.text('user@user.com'), findsOneWidget);
  });

  testWidgets('create register form with empty password field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.registerPassword));
    final result =
        (username.evaluate().first.widget as TextFormField).initialValue;

    // Assert
    expect(result, '');
  });

  testWidgets('should enter password in form field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final email = find.byKey(Key(WidgetKeys.registerPassword));
    await tester.enterText(email, 'user123');

    // Assert
    expect(find.text('user123'), findsOneWidget);
  });

  testWidgets('create register form with empty repeat password field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.registerRepeatPassword));
    final result =
        (username.evaluate().first.widget as TextFormField).initialValue;

    // Assert
    expect(result, '');
  });

  testWidgets('should enter repeat password in form field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final email = find.byKey(Key(WidgetKeys.registerRepeatPassword));
    await tester.enterText(email, 'user123');

    // Assert
    expect(find.text('user123'), findsOneWidget);
  });
}
