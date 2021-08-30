import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          SvgIcons.capybara,
          color: theme.iconTheme.color,
          height: height * 0.25,
        ),
      ),
    );
  }
}
