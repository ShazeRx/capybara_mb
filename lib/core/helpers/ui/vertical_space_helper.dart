import 'package:flutter/material.dart';

class VerticalSpaceHelper {
  static double _deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Widget verticalSpaceSmall(BuildContext context) =>
      SizedBox(height: _deviceHeight(context) * 0.01);

  static Widget verticalSpaceMedium(BuildContext context) =>
      SizedBox(height: _deviceHeight(context) * 0.03);

  static Widget verticalSpaceLarge(BuildContext context) =>
      SizedBox(height: _deviceHeight(context) * 0.05);
}
