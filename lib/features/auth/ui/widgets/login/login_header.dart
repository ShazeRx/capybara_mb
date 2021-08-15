import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Text(
          'Welcome',
          style: theme.textTheme.headline1,
        ),
        Text(
          'in Capibara!',
          style: theme.textTheme.headline2,
        ),
      ],
    );
  }
}
