class IdentityValidator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  static final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');

  static bool isValidEmail(String email) => _emailRegExp.hasMatch(email);

  static bool isValidUsername(String username) {
    return username.length >= 3 &&
        username.length <= 20 &&
        _usernameRegExp.hasMatch(username);
  }

  static bool hasMinLength(String password) => password.length >= 8;
  static bool hasUppercase(String password) => password.contains(RegExp(r'[A-Z]'));
  static bool hasLowercase(String password) => password.contains(RegExp(r'[a-z]'));
  static bool hasDigit(String password) => password.contains(RegExp(r'[0-9]'));
  static bool hasSpecialChar(String password) =>
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  static double getPasswordStrength(String password) {
    if (password.isEmpty) return 0.0;
    double strength = 0.0;
    if (hasMinLength(password)) strength += 0.2;
    if (hasUppercase(password)) strength += 0.2;
    if (hasLowercase(password)) strength += 0.2;
    if (hasDigit(password)) strength += 0.2;
    if (hasSpecialChar(password)) strength += 0.2;
    return strength;
  }
}
