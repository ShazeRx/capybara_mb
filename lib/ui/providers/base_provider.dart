import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/managers/navigation_manager.dart';
import 'package:capybara_app/core/managers/snackbar_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class BaseProvider with ChangeNotifier {
  SnackbarManager _snackbarManager = getIt<SnackbarManager>();
  NavigationManager _navigationManager = getIt<NavigationManager>();

  ProviderState _state = ProviderState.idle;

  ProviderState get state => _state;

  setState(ProviderState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void showSuccess(String success) {
    this._snackbarManager.showSuccess(success);
  }

  void showInfo(String info) {
    this._snackbarManager.showInfo(info);
  }

  void showWarning(String warning) {
    this._snackbarManager.showWarning(warning);
  }

  void showError(String error) {
    this._snackbarManager.showError(error);
  }

  void navigateTo(String route, [dynamic arguments]) {
    this._navigationManager.navigateTo(route, arguments);
  }

  void pushRouteOnStack(String route, [dynamic arguments]) {
    this._navigationManager.pushRouteOnStack(route, arguments);
  }

  void backToPreviousScreen() {
    this._navigationManager.backToPreviousScreen();
  }
}
