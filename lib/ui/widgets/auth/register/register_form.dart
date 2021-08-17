import 'package:capybara_app/core/utils/constants/validation_messages.dart';
import 'package:capybara_app/core/utils/enums/form_field_type.dart';
import 'package:capybara_app/core/utils/helpers/ui/vertical_space_helper.dart';
import 'package:capybara_app/core/utils/helpers/validation/validation_helper.dart';

import 'package:flutter/material.dart';

import '../auth_form_field.dart';
import '../auth_form_wrapper.dart';

class RegisterForm extends StatefulWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = new TextEditingController();
  final nameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final repeatPasswordController = new TextEditingController();

  _saveRegisterData(FormFieldType formField, String? value) {
    // this._registerData[formField] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthFormWrapper(
          form: Form(
            key: RegisterForm._formKey,
            child: Column(
              children: [
                AuthFormField(
                  placeholder: 'name@email.com',
                  // controller: this.emailController,
                  keyboardType: TextInputType.emailAddress,
                  saveData: this._saveRegisterData,
                  authFormFieldType: FormFieldType.email,
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
                  placeholder: 'Full name',
                  // controller: this.nameController,
                  saveData: this._saveRegisterData,
                  authFormFieldType: FormFieldType.fullName,
                  validator: (value) {
                    if (!ValidationHelper.validateIfNotEmpty(value)) {
                      return ValidationMessages.emptyValue;
                    }

                    return null;
                  },
                ),
                AuthFormField(
                  placeholder: 'Password',
                  controller: this.passwordController,
                  saveData: this._saveRegisterData,
                  authFormFieldType: FormFieldType.password,
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
                AuthFormField(
                  placeholder: 'Repeat password',
                  // controller: this.repeatPasswordController,
                  inputAction: TextInputAction.done,
                  saveData: this._saveRegisterData,
                  authFormFieldType: FormFieldType.repeatPassword,
                  validator: (value) {
                    if (!ValidationHelper.validateIfNotEmpty(value)) {
                      return ValidationMessages.emptyValue;
                    }

                    if (!ValidationHelper.validateIfPasswordsAreMatching(
                      this.passwordController.text,
                      value!,
                    )) {
                      return ValidationMessages.differentPasswords;
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        VerticalSpaceHelper.verticalSpaceLarge(context),
        ElevatedButton(
          onPressed: () {
            // this._submitForm();
          },
          child: Text('Register now!'),
        ),
      ],
    );
  }
}
