import 'package:capybara_app/core/constants/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterBackToLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            SvgIcons.arrowBack,
            color: theme.iconTheme.color,
            height: 15,
          ),
        ),
        Text(
          'Come back to login page',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
