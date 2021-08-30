import 'package:capybara_app/core/config/themes/default_theme/default_theme.dart';
import 'package:flutter/material.dart';

InputDecoration defaultInputDecoration({required String hintText}) =>
    InputDecoration(
      hintText: hintText,
      hintStyle: defaultTheme.inputDecorationTheme.hintStyle,
      labelStyle: defaultTheme.inputDecorationTheme.labelStyle,
      enabledBorder: defaultTheme.inputDecorationTheme.enabledBorder,
      focusedBorder: defaultTheme.inputDecorationTheme.focusedBorder,
      border: defaultTheme.inputDecorationTheme.border,
      errorBorder: defaultTheme.inputDecorationTheme.errorBorder,
    );
