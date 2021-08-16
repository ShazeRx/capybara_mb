
import 'package:capybara_app/core/utils/constants/validation_messages.dart';
import 'package:capybara_app/core/utils/enums/form_field_type.dart';
import 'package:capybara_app/core/utils/enums/provider_state.dart';
import 'package:capybara_app/core/utils/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/core/utils/helpers/validation/validation_helper.dart';
import 'package:capybara_app/features/auth/ui/providers/login_provider.dart';
import 'package:capybara_app/features/auth/ui/widgets/auth_form_field.dart';
import 'package:capybara_app/features/auth/ui/widgets/auth_form_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var loginProvider = Provider.of<LoginProvider>(context);

    void _saveLoginData(FormFieldType formField, String? value) {
      // this._loginData[formField] = value;
    }

    return Column(
      children: [
        AuthFormWrapper(
          form: Form(
            key: LoginForm._formKey,
            child: Column(
              children: [
                AuthFormField(
                  placeholder: 'name@email.com',
                  // controller: this.emailController,
                  saveData: _saveLoginData,
                  authFormFieldType: FormFieldType.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!ValidationHelper.validateIfNotEmpty(value)) {
                      return ValidationMessages.emptyValue;
                    }
                    if (!ValidationHelper.validateEmail(value!)) {
                      return ValidationMessages.invalidEmail;
                    }
                    return null;
                  },
                ),
                AuthFormField(
                  placeholder: 'Password',
                  // controller: this.passwordController,
                  authFormFieldType: FormFieldType.password,
                  saveData: _saveLoginData,
                  inputAction: TextInputAction.done,
                  validator: (value) {
                    if (!ValidationHelper.validateIfNotEmpty(value)) {
                      return ValidationMessages.emptyValue;
                    }

                    if (!ValidationHelper.validatePasswordMinLength(value!)) {
                      return ValidationMessages.shortPassword;
                    }

                    if (!ValidationHelper.validatePasswordStrength(value)) {
                      return ValidationMessages.weakPassword;
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        VerticalSpaceHelper.verticalSpaceMedium(context),
        loginProvider.state == ProviderState.busy
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  loginProvider.onLoginPressed();
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
