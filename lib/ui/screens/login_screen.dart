import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/providers/login_provider.dart';
import 'package:capybara_app/ui/widgets/auth/auth_scroll_view.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_create_account_buttons.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_form.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_header.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_recover_password.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<LoginProvider>(),
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
