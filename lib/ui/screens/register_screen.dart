


import 'package:capybara_app/ui/widgets/auth/auth_scroll_view.dart';
import 'package:capybara_app/ui/widgets/auth/register/register_back_to_login.dart';
import 'package:capybara_app/ui/widgets/auth/register/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthScrollView(
        children: [
          RegisterBackToLogin(),
          Text(
            'Registration',
            style: Theme.of(context).textTheme.headline1,
          ),
          RegisterForm(),
        ],
      ),
    );
  }
}
