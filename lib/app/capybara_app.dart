import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/config/routes/app_routes.dart';
import 'package:capybara_app/core/config/themes/app_theme.dart';
import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/ui/states/auth/auth_state_reader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

class CapybaraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthStateReader>(
          create: (_) => getIt<AuthStateReader>(),
        )
      ],
      child: Consumer<AuthStateReader>(builder: (_, auth, __) {
        return MaterialApp(
          title: 'Capybara',
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routes: appRoutes,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [StackedService.routeObserver],
          initialRoute: RoutePaths.loginRoute,
        );
      }),
    );
  }
}
