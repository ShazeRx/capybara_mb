import 'package:capybara_app/app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_services/stacked_services.dart';

class MockSnackbarService extends Mock implements SnackbarService {}

class MockDialogService extends Mock implements DialogService {}

class MockNavigationService extends Mock implements NavigationService {}

MockDialogService mockDialogService = MockDialogService();
MockNavigationService mockNavigationService = MockNavigationService();
MockSnackbarService mockSnackbarService = MockSnackbarService();

void registerThirdPartyServices() {
  _registerMockNavigationService();
  _registerMockDialogService();
  _registerMockSnackbarService();
}

void unregisterThirdPartyServices() {
  getIt.unregister<NavigationService>();
  getIt.unregister<DialogService>();
  getIt.unregister<SnackbarService>();
}

void _registerMockNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  getIt.registerSingleton<NavigationService>(mockNavigationService);
}

void _registerMockDialogService() {
  _removeRegistrationIfExists<DialogService>();
  getIt.registerSingleton<DialogService>(mockDialogService);
  when(() => mockDialogService.showDialog()).thenAnswer((_) => Future.value());
}

void _registerMockSnackbarService() {
  _removeRegistrationIfExists<SnackbarService>();
  getIt.registerSingleton<SnackbarService>(mockSnackbarService);
}

void _removeRegistrationIfExists<T extends Object>() {
  if (getIt.isRegistered<T>()) {
    getIt.unregister<T>();
  }
}

Widget makeTestableWidgetWithScaffold(Widget widget) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(),
      child: Scaffold(
        body: widget,
      ),
    ),
  );
}

Widget makeTestableWidgetWithoutScaffold(Widget widget) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(),
      child: widget,
    ),
  );
}
