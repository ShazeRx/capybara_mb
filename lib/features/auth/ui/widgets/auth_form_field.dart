
import 'package:capybara_app/core/utils/enums/form_field_type.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final String placeholder;
  final Function(FormFieldType, String?) saveData;
  final FormFieldType authFormFieldType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final TextInputType keyboardType;

  AuthFormField({
    required this.placeholder,
    required this.saveData,
    required this.authFormFieldType,
    this.validator,
    this.controller,
    this.inputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      controller: this.controller,
      style: theme.inputDecorationTheme.hintStyle,
      decoration: InputDecoration(
        hintText: this.placeholder,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        labelStyle: theme.inputDecorationTheme.labelStyle,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        border: InputBorder.none,
        errorBorder: theme.inputDecorationTheme.errorBorder,
      ),
      textInputAction: this.inputAction,
      keyboardType: this.keyboardType,
      validator: this.validator,
      obscureText: this.authFormFieldType == FormFieldType.Password ||
          this.authFormFieldType == FormFieldType.RepeatPassword,
      onSaved: (value) => this.saveData(this.authFormFieldType, value),
    );
  }
}
