import 'package:capybara_app/features/auth/ui/providers/login_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LoginProvider());
  // locator.registerLazySingleton(() => L());
}
