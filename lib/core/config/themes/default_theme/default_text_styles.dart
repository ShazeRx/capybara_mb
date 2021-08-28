import 'package:flutter/material.dart';

import 'default_colors.dart';

class DefaultTextStyles {
  DefaultTextStyles._();

  static const TextStyle paragraphTextStyle = TextStyle(
    fontSize: 20,
    color: DefaultColors.textColor,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
  );
  static const TextStyle headline1TextStyle = TextStyle(
    fontSize: 45,
    color: DefaultColors.textColor,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  static const TextStyle headline2TextStyle = TextStyle(
    fontSize: 20,
    color: DefaultColors.textColor,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
    letterSpacing: 0,
  );
  static const TextStyle placeholderTextStyle = TextStyle(
    fontSize: 20,
    color: DefaultColors.textColor,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 20,
    color: DefaultColors.textColor,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle bottomNavigationBarTextStyle = TextStyle(
    fontSize: 12,
    color: DefaultColors.textColor,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 12,
    color: DefaultColors.textColor,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w300,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );
}
