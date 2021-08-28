import 'package:capybara_app/core/constants/widget_keys.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/ui/providers/login_provider.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../setup/test_helpers.dart';

class MockLoginProvider extends Mock implements LoginProvider {}

void main() {
  late MockLoginProvider mockLoginProvider;
  setUp(() {
    mockLoginProvider = MockLoginProvider();
  });

  Future<void> pumpTestWidget(WidgetTester tester) async {
    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

    await tester.pumpWidget(
      ChangeNotifierProvider<LoginProvider>.value(
        value: mockLoginProvider,
        child: makeTestableWidgetWithScaffold(LoginForm(
          formKey: _formKey,
        )),
      ),
    );
  }

  void mockProviderStateIdle() {
    when(() => mockLoginProvider.state).thenReturn(ProviderState.idle);
  }

  testWidgets('create login form with empty username field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.loginUsername));
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
    final username = find.byKey(Key(WidgetKeys.loginUsername));
    await tester.enterText(username, 'user');

    // Assert
    expect(find.text('user'), findsOneWidget);
  });

  testWidgets('create login form with empty password field',
      (WidgetTester tester) async {
    // Arrange
    mockProviderStateIdle();
    await pumpTestWidget(tester);

    //  Act
    final username = find.byKey(Key(WidgetKeys.loginUsername));
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
    final password = find.byKey(Key(WidgetKeys.loginPassword));
    await tester.enterText(password, 'user123');

    // Assert
    expect(find.text('user123'), findsOneWidget);
  });
}
