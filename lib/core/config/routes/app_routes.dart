import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/ui/screens/auth/login_screen.dart';
import 'package:capybara_app/ui/screens/auth/register_screen.dart';

import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      RoutePaths.loginRoute: (ctx) => LoginScreen(),
      RoutePaths.registerRoute: (ctx) => RegisterScreen(),
    };
