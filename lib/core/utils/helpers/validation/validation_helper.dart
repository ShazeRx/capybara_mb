class ValidationHelper {
  static bool validateIfNotEmpty(String? value) {
    if (value == null || value.isEmpty) return false;

    return true;
  }

  static bool validateEmail(String value) {
    if (!value.contains('@')) return false;

    return true;
  }

  static bool validatePasswordMinLength(String value) {
    if (value.length < 8) return false;

    return true;
  }

  static bool validatePasswordStrength(String value) {
    // Minimum 1 upper and 1 lower character
    RegExp regEx = new RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

    if (!regEx.hasMatch(value)) return false;

    return true;
  }

  static bool validateIfPasswordsAreMatching(String password, String repeatedPassword) {
    print(password);
    if (password != repeatedPassword) return false;

    return true;
  }
}
