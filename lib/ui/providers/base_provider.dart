

import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier {
  ProviderState _state = ProviderState.idle;

  ProviderState get state => _state;

  void setState(ProviderState viewState) {
    _state = viewState;
    notifyListeners();
  }
}