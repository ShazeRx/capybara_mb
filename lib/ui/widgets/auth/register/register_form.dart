import 'package:capybara_app/core/constants/validation_messages.dart';
import 'package:capybara_app/core/constants/widget_keys.dart';
import 'package:capybara_app/core/enums/provider_state.dart';
import 'package:capybara_app/core/enums/validator.dart';
import 'package:capybara_app/core/config/themes/default_theme/default_input_decoration.dart';
import 'package:capybara_app/core/helpers/ui/focus_scope_helper.dart';
import 'package:capybara_app/core/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/ui/providers/auth/register_provider.dart';
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
  void dispose() {
    this._formKey.currentState?.reset();
    this._passwordController.dispose();
    super.dispose();
  }

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
                      textInputAction: TextInputAction.next,
                      onSaved: (value) =>
                          register.registerData['username'] = value!,
                    ),
                    TextFormField(
                      key: Key(WidgetKeys.registerEmail),
                      style: theme.inputDecorationTheme.hintStyle,
                      decoration: defaultInputDecoration(hintText: 'Email'),
                      validator: Validator.email.validator,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) =>
                          register.registerData['email'] = value!,
                    ),
                    TextFormField(
                      key: Key(WidgetKeys.registerPassword),
                      controller: this._passwordController,
                      style: theme.inputDecorationTheme.hintStyle,
                      decoration: defaultInputDecoration(hintText: 'Password'),
                      validator: Validator.password.validator,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      onSaved: (value) =>
                          register.registerData['password'] = value!,
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
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpaceHelper.verticalSpaceLarge(context),
            register.state == ProviderState.busy
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      FocusScopeHelper.unfocus(context);
                      if (this._formKey.currentState!.validate()) {
                        this._formKey.currentState!.save();
                        await register.onRegisterSubmitted();
                      }
                    },
                    child: Text(
                      'Register now!',
                      style: theme.textTheme.bodyText2,
                    ),
                  ),
          ],
        );
      },
    );
  }
}
