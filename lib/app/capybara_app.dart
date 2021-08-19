import 'package:capybara_app/core/config/routes/app_routes.dart';
import 'package:capybara_app/core/config/themes/app_theme.dart';
import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class CapybaraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: RoutePaths.loginRoute,
      routes: appRoutes,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
