import 'package:capybara_app/core/enums/validator.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:flutter/material.dart';

import '../auth_form_wrapper.dart';

class LoginForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  void _submitForm() {
    LoginForm._formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        AuthFormWrapper(
          form: Form(
            key: LoginForm._formKey,
            child: Column(
              children: [
                TextFormField(
                  style: theme.inputDecorationTheme.hintStyle,
                  decoration: defaultInputDecoration(hintText: 'Username'),
                  validator: Validator.username.validator,
                ),
                TextFormField(
                  style: theme.inputDecorationTheme.hintStyle,
                  decoration: defaultInputDecoration(hintText: 'Password'),
                  validator: Validator.password.validator,
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
        VerticalSpaceHelper.verticalSpaceMedium(context),
        ElevatedButton(
          onPressed: () {
            this._submitForm();
          },
          child: Text(
            'Login',
            style: theme.textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
