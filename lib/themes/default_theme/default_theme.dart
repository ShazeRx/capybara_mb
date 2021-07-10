import 'package:capybara_app_new/themes/default_theme/default_text_styles.dart';
import 'package:flutter/material.dart';

import 'default_colors.dart';

ThemeData get defaultTheme => ThemeData(
      scaffoldBackgroundColor: DefaultColors.backgroundColor,
      fontFamily: 'Ubuntu',
      textTheme: TextTheme(
        bodyText2: DefaultTextStyles.paragraphTextStyle,
        headline1: DefaultTextStyles.headline1TextStyle,
        headline2: DefaultTextStyles.headline2TextStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: DefaultTextStyles.placeholderTextStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: DefaultColors.buttonColor,
          textStyle: DefaultTextStyles.paragraphTextStyle,
        ),
      ),
    );
