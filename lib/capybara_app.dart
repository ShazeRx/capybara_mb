import 'package:capybara_app_new/themes/default_theme/default_theme.dart';
import 'package:capybara_app_new/themes/main_theme.dart';
import 'package:flutter/material.dart';

class CapybaraApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Capybara', theme: mainTheme);
  }
}
