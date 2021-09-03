import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/config/routes/app_routes.dart';
import 'package:capybara_app/core/config/themes/app_theme.dart';
import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/ui/states/auth/auth_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CapybaraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<AuthStateNotifier>(),
        )
      ],
      child: Consumer<AuthStateNotifier>(builder: (_, auth, __) {
        return GetMaterialApp(
          title: 'Capybara',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routes: appRoutes,
          initialRoute: RoutePaths.loginRoute,
        );
      }),
    );
  }
}
