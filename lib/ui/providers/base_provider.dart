import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_services/stacked_services.dart';

class BaseProvider with ChangeNotifier {
  DialogService _dialogService = getIt<DialogService>();
  NavigationService _navigationService = getIt<NavigationService>();
  SnackbarService _snackbarService = getIt<SnackbarService>();

  ProviderState _state = ProviderState.idle;

  ProviderState get state => _state;

  setState(ProviderState viewState) {
    _state = viewState;
    notifyListeners();
  }

  //TODO - add different snackbars

  void showSuccess(String success) {
    this._snackbarService.showSnackbar(message: success);
  }

  void showInfo(String info) {
    this._snackbarService.showSnackbar(message: info);
  }

  void showWarning(String warning) {
    this._snackbarService.showSnackbar(message: warning);
  }

  void showError(Failure failure) {
    this._snackbarService.showSnackbar(message: failure.message);
  }

  void navigateTo(String route) {
    this._navigationService.clearStackAndShow(route);
  }

  void backToPreviousScreen() {
    this._navigationService.back();
  }
}
