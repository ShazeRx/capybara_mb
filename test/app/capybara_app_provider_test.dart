import 'package:capybara_app/app/capybara_app_provider.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/usecases/auth/fetch_token.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/states/auth/token_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../setup/test_helpers.dart';

class MockFetchToken extends Mock implements FetchToken {}

class MockTokenState extends Mock implements TokenState {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late MockFetchToken mockFetchToken;
  late MockTokenState mockTokenState;
  late CapybaraAppProvider provider;

  final tToken = Token(access: '123', refresh: '321');

  mockFetchTokenCall() {
    when(() => mockFetchToken(NoParams()))
        .thenAnswer((_) async => Right(tToken));
  }

  setUp(() {
    registerManagers();

    mockFetchToken = MockFetchToken();
    mockTokenState = MockTokenState();

    mockFetchTokenCall();

    provider = CapybaraAppProvider(
      fetchToken: mockFetchToken,
      tokenState: mockTokenState,
    );

    registerFallbackValue<NoParams>(FakeNoParams());
  });

  tearDown(() {
    unregisterManagers();
  });

  group('fetch token', () {
    test('should call fetch token usecase in provider constructor', () {
      //Assert
      verify(() => mockFetchToken(NoParams()));
    });

    test('should change provider state to busy while calling fetch token', () {
      // Act
      provider.fetchToken();
      final result = provider.state;

      //Assert
      expect(result, ProviderState.busy);
    });

    test('should change provider state to idle after fetch token call',
        () async {
      // Act
      await provider.fetchToken();
      final result = provider.state;

      //Assert
      expect(result, ProviderState.idle);
    });
  });

  test('should set token result in state when token is present in cache',
      () async {
    // Assert
    verify(() => mockTokenState.setToken(tToken));
  });
}
