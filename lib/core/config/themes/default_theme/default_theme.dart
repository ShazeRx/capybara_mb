import 'package:flutter/material.dart';

import 'default_colors.dart';
import 'default_text_styles.dart';

ThemeData get defaultTheme => ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: DefaultColors.buttonColor,
        iconTheme: IconThemeData(
          color: DefaultColors.textColor,
        ),
        titleTextStyle: DefaultTextStyles.appBarTextStyle,
      ),
      cardColor: DefaultColors.accentColor,
      buttonColor: DefaultColors.buttonColor,
      scaffoldBackgroundColor: DefaultColors.backgroundColor,
      backgroundColor: DefaultColors.backgroundColor,
      fontFamily: 'Ubuntu',
      errorColor: DefaultColors.errorColor,
      textTheme: TextTheme(
        bodyText2: DefaultTextStyles.paragraphTextStyle,
        headline1: DefaultTextStyles.headline1TextStyle,
        headline2: DefaultTextStyles.headline2TextStyle,
        subtitle1: DefaultTextStyles.subtitleTextStyle,
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
      iconTheme: IconThemeData(
        color: DefaultColors.textColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DefaultColors.buttonColor,
        unselectedItemColor: DefaultColors.accentColor,
        selectedItemColor: DefaultColors.textColor,
        selectedLabelStyle: DefaultTextStyles.bottomNavigationBarTextStyle,
      ),
    );
