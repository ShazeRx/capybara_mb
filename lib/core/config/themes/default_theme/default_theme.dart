import 'package:flutter/material.dart';

import 'default_colors.dart';
import 'default_text_styles.dart';

ThemeData get defaultTheme => ThemeData(
      scaffoldBackgroundColor: DefaultColors.backgroundColor,
      fontFamily: 'Ubuntu',
      errorColor: DefaultColors.errorColor,
      textTheme: TextTheme(
        bodyText2: DefaultTextStyles.paragraphTextStyle,
        headline1: DefaultTextStyles.headline1TextStyle,
        headline2: DefaultTextStyles.headline2TextStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: DefaultTextStyles.placeholderTextStyle,
        labelStyle: DefaultTextStyles.placeholderTextStyle,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DefaultColors.textColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DefaultColors.textColor,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: DefaultColors.textColor,
          ),
        ),
        errorMaxLines: 3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: DefaultColors.buttonColor,
          textStyle: DefaultTextStyles.paragraphTextStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: DefaultColors.textColor,
            ),
          ),
        ),
      ),
    );
