import 'package:get/get.dart';

abstract class NavigationManager {
  void navigateTo(String route, [dynamic arguments]);

  void pushRouteOnStack(String route, [dynamic arguments]);

  void backToPreviousScreen();
}

class NavigationManagerImpl implements NavigationManager {
  void navigateTo(String route, [dynamic arguments]) {
    Get.offNamed(route, arguments: arguments);
  }

  void pushRouteOnStack(String route, [dynamic arguments]) {
    Get.toNamed(route, arguments: arguments);
  }

  void backToPreviousScreen() {
    Get.back();
  }
}
