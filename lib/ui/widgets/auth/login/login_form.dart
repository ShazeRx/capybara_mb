import 'package:capybara_app/core/constants/route_paths.dart';
import 'package:capybara_app/core/constants/widget_keys.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/enums/validator.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/helpers/ui/focus_scope_helper.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/providers/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_form_wrapper.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> _formKey;

  LoginForm({required formKey}) : this._formKey = formKey;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void dispose() {
    widget._formKey.currentState?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<LoginProvider>(builder: (_, login, __) {
      return Column(
        children: [
          AuthFormWrapper(
            form: Form(
              key: widget._formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: Key(WidgetKeys.loginUsername),
                    style: theme.inputDecorationTheme.hintStyle,
                    decoration: defaultInputDecoration(hintText: 'Username'),
                    validator: Validator.username.validator,
                    onSaved: (value) => login.loginData['username'] = value!,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    key: Key(WidgetKeys.loginPassword),
                    style: theme.inputDecorationTheme.hintStyle,
                    decoration: defaultInputDecoration(hintText: 'Password'),
                    validator: Validator.password.validator,
                    obscureText: true,
                    onSaved: (value) => login.loginData['password'] = value!,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
          VerticalSpaceHelper.verticalSpaceMedium(context),
          login.state == ProviderState.busy
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    // FocusScopeHelper.unfocus(context);
                    // if (this.widget._formKkey.currentState!.validate()) {
                    //   this.widget._formKey.currentState!.save();
                    //   await login.onLoginSubmitted();
                    // }
                    Navigator.of(context).pushReplacementNamed(
                      RoutePaths.homeRoute,
                    );
                  },
                  child: Text('Login'),
                ),
        ],
      );
    });
  }
}
