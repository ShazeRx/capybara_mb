import 'package:capybara_app/app/injection_container.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/providers/auth/login_provider.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_create_account_buttons.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_form.dart';
import 'package:capybara_app/ui/widgets/auth/login/login_header.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<LoginProvider>(),
      child: Scaffold(
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VerticalSpaceHelper.verticalSpaceSmall(context),
                  LoginHeader(),
                  LoginForm(formKey: _formKey),
                  LoginCreateAccountButtons(
                    formKey: _formKey,
                  ),
                  //TODO - implement password recover
                  // LoginRecoverPassword(),
                  VerticalSpaceHelper.verticalSpaceSmall(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
