import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/errors/failures/failure.dart';
import 'package:capybara_app/core/helpers/failures/failure_messages_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked_services/stacked_services.dart';

class BaseProvider with ChangeNotifier {
  DialogService dialogService = getIt<DialogService>();
  NavigationService navigationService = getIt<NavigationService>();
  SnackbarService snackbarService = getIt<SnackbarService>();

  ProviderState _state = ProviderState.idle;

  ProviderState get state => _state;

  void setState(ProviderState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void showError(Failure failure) {
    final errorMessage = FailureMessagesHelper.getMessage(failure);
    this.snackbarService.showSnackbar(message: errorMessage);
  }
}
