import 'package:capybara_app/core/constants/validation_messages.dart';
import 'package:form_field_validator/form_field_validator.dart';

enum Validator { required, username, email, password }

extension ValidatorExtension on Validator {
  static final validators = {
    Validator.required: _requiredValidator,
    Validator.username: _usernameValidators,
    Validator.email: _emailValidators,
    Validator.password: _passwordValidators
  };

  MultiValidator get validator => validators[this]!;
}

MultiValidator get _requiredValidator => MultiValidator(
      [
        RequiredValidator(errorText: ValidationMessages.required),
      ],
    );

MultiValidator get _usernameValidators => MultiValidator(
      [
        RequiredValidator(errorText: ValidationMessages.required),
      ],
    );

MultiValidator get _emailValidators => MultiValidator(
      [
        RequiredValidator(errorText: ValidationMessages.required),
        EmailValidator(errorText: ValidationMessages.invalidEmail),
      ],
    );

MultiValidator get _passwordValidators => MultiValidator(
      [
        RequiredValidator(errorText: ValidationMessages.required),
        MinLengthValidator(8, errorText: ValidationMessages.shortPassword),
        PatternValidator(
          r'(?=.*?[#?!@$%^&*-])',
          errorText: ValidationMessages.passwordSpecialCharacter,
        ),
        PatternValidator(
          r'(?=.*[a-z])(?=.*[A-Z])\w+',
          errorText: ValidationMessages.passwordUppercaseLowercase,
        )
      ],
    );
