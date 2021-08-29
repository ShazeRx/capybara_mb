import 'package:capybara_app/app/capybara_app.dart';
import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/app/precache_svg_icons.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  await precacheSvgIcons();
  runApp(CapybaraApp());
}
