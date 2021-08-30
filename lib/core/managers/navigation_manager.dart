import 'package:stacked_services/stacked_services.dart';

abstract class NavigationManager {
  void navigateTo(String route, [dynamic arguments]);

  void pushRouteOnStack(String route, [dynamic arguments]);

  void backToPreviousScreen();
}

class NavigationManagerImpl implements NavigationManager {
  late NavigationService _navigationService;

  NavigationManagerImpl({
    required navigationService,
  }) : this._navigationService = navigationService;

  void navigateTo(String route, [dynamic arguments]) {
    this._navigationService.clearStackAndShow(route, arguments: arguments);
  }

  void pushRouteOnStack(String route, [dynamic arguments]) {
    this._navigationService.navigateTo(route, arguments: arguments);
  }

  void backToPreviousScreen() {
    this._navigationService.back();
  }
}
