import 'package:capybara_app/app/capybara_app.dart';
import 'package:capybara_app/app/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  await registerDependencies();
  runApp(CapybaraApp());
}
