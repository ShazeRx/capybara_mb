import 'package:capybara_app/core/constants/validation_messages.dart';
import 'package:capybara_app/core/enums/validator.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../auth_form_wrapper.dart';

class RegisterForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _passwordController = new TextEditingController();

  void _submitForm() {
    RegisterForm._formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        AuthFormWrapper(
          form: Form(
            key: RegisterForm._formKey,
            child: Column(
              children: [
                TextFormField(
                  style: theme.inputDecorationTheme.hintStyle,
                  decoration: defaultInputDecoration(hintText: 'Username'),
                  validator: Validator.username.validator,
                ),
                TextFormField(
                  style: theme.inputDecorationTheme.hintStyle,
                  decoration: defaultInputDecoration(hintText: 'Email'),
                  validator: Validator.email.validator,
                ),
                TextFormField(
                  controller: this._passwordController,
                  style: theme.inputDecorationTheme.hintStyle,
                  decoration: defaultInputDecoration(hintText: 'Password'),
                  validator: Validator.password.validator,
                ),
                TextFormField(
                  style: theme.inputDecorationTheme.hintStyle,
                  decoration:
                      defaultInputDecoration(hintText: 'Repeat password'),
                  validator: (value) => MatchValidator(
                    errorText: ValidationMessages.differentPasswords,
                  ).validateMatch(
                    value!,
                    this._passwordController.text,
                  ),
                ),
              ],
            ),
          ),
        ),
        VerticalSpaceHelper.verticalSpaceLarge(context),
        ElevatedButton(
          onPressed: () {
            this._submitForm();
          },
          child: Text('Register now!'),
        ),
      ],
    );
  }
}
