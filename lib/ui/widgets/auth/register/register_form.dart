import 'package:capybara_app/core/constants/validation_messages.dart';
import 'package:capybara_app/core/constants/widget_keys.dart';
import 'package:capybara_app/core/enums/validator.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import '../auth_form_wrapper.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Consumer<RegisterProvider>(
      builder: (_, register, __) {
        return Column(
          children: [
            AuthFormWrapper(
              form: Form(
                key: this._formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: Key(WidgetKeys.registerUsername),
                      style: theme.inputDecorationTheme.hintStyle,
                      decoration: defaultInputDecoration(hintText: 'Username'),
                      validator: Validator.username.validator,
                    ),
                    TextFormField(
                      key: Key(WidgetKeys.registerEmail),
                      style: theme.inputDecorationTheme.hintStyle,
                      decoration: defaultInputDecoration(hintText: 'Email'),
                      validator: Validator.email.validator,
                    ),
                    TextFormField(
                      key: Key(WidgetKeys.registerPassword),
                      controller: this._passwordController,
                      style: theme.inputDecorationTheme.hintStyle,
                      decoration: defaultInputDecoration(hintText: 'Password'),
                      validator: Validator.password.validator,
                      obscureText: true,
                    ),
                    TextFormField(
                      key: Key(WidgetKeys.registerRepeatPassword),
                      style: theme.inputDecorationTheme.hintStyle,
                      decoration:
                          defaultInputDecoration(hintText: 'Repeat password'),
                      validator: (value) => MatchValidator(
                        errorText: ValidationMessages.differentPasswords,
                      ).validateMatch(
                        value!,
                        this._passwordController.text,
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpaceHelper.verticalSpaceLarge(context),
            ElevatedButton(
                onPressed: () async {
                  if (this._formKey.currentState!.validate()) {
                    this._formKey.currentState!.save();
                    await register.onRegisterSubmitted();
                  }
                },
                child: Text(
                  'Register now!',
                  style: theme.textTheme.bodyText2,
                )),
          ],
        );
      },
    );
  }
}
