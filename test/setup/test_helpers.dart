import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/managers/navigation_manager.dart';
import 'package:capybara_app/core/managers/snackbar_manager.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockSnackbarManager extends Mock implements SnackbarManager {}

// class MockDialogManager extends Mock implements DialogManager {}

class MockNavigationManager extends Mock implements NavigationManager {}

// MockDialogManager mockDialogManager = MockDialogManager();
MockNavigationManager mockNavigationManager = MockNavigationManager();
MockSnackbarManager mockSnackbarManager = MockSnackbarManager();

void registerManagers() {
  _registerMockNavigationManager();
  // _registerMockDialogManager();
  _registerMockSnackbarManager();
}

void unregisterManagers() {
  getIt.unregister<NavigationManager>();
  // getIt.unregister<DialogManager>();
  getIt.unregister<SnackbarManager>();
}

void _registerMockNavigationManager() {
  _removeRegistrationIfExists<NavigationManager>();
  getIt.registerSingleton<NavigationManager>(mockNavigationManager);
}

// void _registerMockDialogManager() {
//   _removeRegistrationIfExists<DialogManager>();
//   getIt.registerSingleton<DialogManager>(mockDialogManager);
//   when(() => mockDialogManager.showDialog()).thenAnswer((_) => Future.value());
// }

void _registerMockSnackbarManager() {
  _removeRegistrationIfExists<SnackbarManager>();
  getIt.registerSingleton<SnackbarManager>(mockSnackbarManager);
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
