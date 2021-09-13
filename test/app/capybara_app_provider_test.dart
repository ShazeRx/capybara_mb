import 'package:capybara_app/app/capybara_app_provider.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/domain/entities/auth/token.dart';
import 'package:capybara_app/domain/usecases/usecase.dart';
import 'package:capybara_app/ui/facades/auth_facade.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../setup/test_helpers.dart';

class MockAuthFacade extends Mock implements AuthFacade {}

void main() {
  late MockAuthFacade mockAuthFacade;
  late CapybaraAppProvider provider;

  final tToken = Token(access: '123', refresh: '321');

  mockFetchToken() {
    when(() => mockAuthFacade.fetchToken())
        .thenAnswer((_) async => Right(tToken));
  }

  setUp(() {
    registerManagers();

    mockAuthFacade = MockAuthFacade();

    mockFetchToken();

    provider = CapybaraAppProvider(
      authFacade: mockAuthFacade,
    );
  });

  tearDown(() {
    unregisterManagers();
  });

  group('fetch token', () {
    test('should call facade fetch token in provider constructor', () {
      //Assert
      verify(() => mockAuthFacade.fetchToken());
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
}
