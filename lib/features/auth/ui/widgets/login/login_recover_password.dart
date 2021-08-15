import 'package:flutter/material.dart';

class LoginRecoverPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text(
        'Forgot password? Recover here',
        style: theme.textTheme.bodyText2,
      ),
    );
  }
}
