import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/enums/validator.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/helpers/ui/focus_scope_helper.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_form_wrapper.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<LoginProvider>(builder: (_, login, __) {
      return Column(
        children: [
          AuthFormWrapper(
            form: Form(
              key: this._formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: theme.inputDecorationTheme.hintStyle,
                    decoration: defaultInputDecoration(hintText: 'Username'),
                    validator: Validator.username.validator,
                    onSaved: (value) => login.loginData['username'] = value!,
                  ),
                  TextFormField(
                    style: theme.inputDecorationTheme.hintStyle,
                    decoration: defaultInputDecoration(hintText: 'Password'),
                    validator: Validator.password.validator,
                    obscureText: true,
                    onSaved: (value) => login.loginData['password'] = value!,
                  ),
                ],
              ),
            ),
          ),
          VerticalSpaceHelper.verticalSpaceMedium(context),
          login.state == ProviderState.busy
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    FocusScopeHelper.unfocus(context);
                    if (this._formKey.currentState!.validate()) {
                      this._formKey.currentState!.save();
                      login.onLoginSubmitted();
                    }
                  },
                  child: Text(
                    'Login',
                    style: theme.textTheme.bodyText2,
                  ),
                ),
        ],
      );
    });
  }
}
