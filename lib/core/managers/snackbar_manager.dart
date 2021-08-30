import 'package:stacked_services/stacked_services.dart';

abstract class SnackbarManager {
  void showSuccess(String success);

  void showInfo(String info);

  void showWarning(String warning);

  void showError(String error);
}

class SnackbarManagerImpl implements SnackbarManager {
  late SnackbarService _snackbarService;

  SnackbarManagerImpl({
    required SnackbarService snackbarService,
  }) : this._snackbarService = snackbarService;

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

  void showError(String error) {
    this._snackbarService.showSnackbar(message: error);
  }
}
