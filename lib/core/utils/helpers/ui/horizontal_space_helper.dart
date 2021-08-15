import 'package:flutter/material.dart';

class HorizontalSpaceHelper {
  static double _deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Widget horizontalSpaceSmall(BuildContext context) =>
      SizedBox(width: _deviceWidth(context) * 0.01);

  static Widget horizontalSpaceMedium(BuildContext context) =>
      SizedBox(width: _deviceWidth(context) * 0.03);

  static Widget horizontalSpaceLarge(BuildContext context) =>
      SizedBox(width: _deviceWidth(context) * 0.05);
}
