import 'package:capybara_app/app/service_locator.dart';
import 'package:capybara_app/core/utils/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/features/auth/ui/providers/login_provider.dart';
import 'package:capybara_app/features/auth/ui/widgets/auth_scroll_view.dart';
import 'package:capybara_app/features/auth/ui/widgets/login/login_create_account_buttons.dart';
import 'package:capybara_app/features/auth/ui/widgets/login/login_form.dart';
import 'package:capybara_app/features/auth/ui/widgets/login/login_header.dart';
import 'package:capybara_app/features/auth/ui/widgets/login/login_recover_password.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (ctx) => locator<LoginProvider>(),
      child: Scaffold(
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
      ),
    );
  }
}
