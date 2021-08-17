import 'package:capybara_app/core/utils/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/widgets/auth_scroll_view.dart';
import 'package:capybara_app/ui/widgets/login/login_create_account_buttons.dart';
import 'package:capybara_app/ui/widgets/login/login_form.dart';
import 'package:capybara_app/ui/widgets/login/login_header.dart';
import 'package:capybara_app/ui/widgets/login/login_recover_password.dart';


import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthScrollView(
        children: [
          VerticalSpaceHelper.verticalSpaceSmall(context),
          LoginHeader(),
          LoginForm(),
          LoginCreateAccountButtons(),
          LoginRecoverPassword(),
          VerticalSpaceHelper.verticalSpaceSmall(context),
        ],
      ),
    );
  }
}
