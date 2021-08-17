import 'package:capybara_app/core/constants/validation_messages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_field_validator/form_field_validator.dart';

void main() {
  late RequiredValidator requiredValidator;
  late EmailValidator emailValidator;
  late MinLengthValidator minLengthValidator;
  late PatternValidator specialCharacterValidator;
  late PatternValidator uppercaseLowercaseValidator;

  setUp(() {
    requiredValidator = RequiredValidator(
      errorText: ValidationMessages.required,
    );

    emailValidator = EmailValidator(
      errorText: ValidationMessages.invalidEmail,
    );

    minLengthValidator = MinLengthValidator(
      8,
      errorText: ValidationMessages.shortPassword,
    );

    specialCharacterValidator = PatternValidator(
      r'(?=.*?[#?!@$%^&*-])',
      errorText: ValidationMessages.passwordSpecialCharacter,
    );

    uppercaseLowercaseValidator = PatternValidator(
      r'(?=.*[a-z])(?=.*[A-Z])\w+',
      errorText: ValidationMessages.passwordUppercaseLowercase,
    );
  });

  group('required validator', () {
    test(
      'should return "required" message if value is empty',
      () async {
        // Arrange
        final value = '';

        // Act
        final result = requiredValidator(value);

        // Assert
        expect(result, ValidationMessages.required);
      },
    );

    // Null check is not necessary, because text form field default value is empty string

    test(
      'should return null if value is not empty',
      () async {
        // Arrange
        final value = '123';

        // Act
        final result = requiredValidator(value);

        // Assert
        expect(result, null);
      },
    );
  });

  group('email validator', () {
    test(
      'should return "invalid email" message if value does not contain "@" symbol',
      () async {
        // Arrange
        final value = 'mail.com';

        // Act
        final result = emailValidator(value);

        // Assert
        expect(result, ValidationMessages.invalidEmail);
      },
    );

    test(
      'should return "invalid email" message if value does not contain "." symbol',
      () async {
        // Arrange
        final value = 'mail@com';

        // Act
        final result = emailValidator(value);

        // Assert
        expect(result, ValidationMessages.invalidEmail);
      },
    );

    test(
      'should return null if email is valid',
      () async {
        // Arrange
        final value = 'mail@mail.com';

        // Act
        final result = emailValidator(value);

        // Assert
        expect(result, null);
      },
    );
  });

  group('min length validator', () {
    test(
        'should return "short password" message if value is shorter than 8 digits',
        () {
      // Arrange
      final value = "1234567";

      // Act
      final result = minLengthValidator(value);

      // Arrange
      expect(result, equals(ValidationMessages.shortPassword));
    });

    test('should return null message if value is greater or equal to 8 digits',
        () {
      // Arrange
      final value = "12345678";

      // Act
      final result = minLengthValidator(value);

      // Arrange
      expect(result, equals(null));
    });
  });

  group('special character validator', () {
    test(
        'should return "password special character" message if value does not contain at least one special character',
        () {
      // Arrange
      final value = "password123password";

      // Act
      final result = specialCharacterValidator(value);

      // Arrange
      expect(result, equals(ValidationMessages.passwordSpecialCharacter));
    });

    test(
        'should return null message if value does contain at least one special character',
        () {
      // Arrange
      final value = "password123!";

      // Act
      final result = specialCharacterValidator(value);

      // Arrange
      expect(result, equals(null));
    });
  });

  group('uppercase lowercase validator', () {
    test(
        'should return "password uppercase lowercase" message if value does not contain at least one uppercase character',
        () {
      // Arrange
      final value = "password123!";

      // Act
      final result = uppercaseLowercaseValidator(value);

      // Arrange
      expect(result, equals(ValidationMessages.passwordUppercaseLowercase));
    });

     test(
        'should return "password uppercase lowercase" message if value does not contain at least one lowercase character',
        () {
      // Arrange
      final value = "PASSWORD123!";

      // Act
      final result = uppercaseLowercaseValidator(value);

      // Arrange
      expect(result, equals(ValidationMessages.passwordUppercaseLowercase));
    });

    test(
        'should return null if value does contain at least one lowercase and one uppercase character',
        () {
      // Arrange
      final value = "Password123!";

      // Act
      final result = uppercaseLowercaseValidator(value);

      // Arrange
      expect(result, equals(null));
    });
  });
}
