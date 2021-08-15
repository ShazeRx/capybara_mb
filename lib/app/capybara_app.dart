

import 'package:capybara_app/core/utils/constants/route_paths.dart';
import 'package:capybara_app/core/utils/routes/app_routes.dart';
import 'package:capybara_app/core/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CapybaraApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: RoutePaths.loginRoute,
      routes: appRoutes,
    );
  }
}
