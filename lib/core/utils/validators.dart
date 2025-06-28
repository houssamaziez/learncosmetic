class Validators {
  /// Validates that the field is not empty
  static String? required(
    String? value, {
    String message = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validates an email address
  static String? email(
    String? value, {
    String message = 'Invalid email address',
  }) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  /// Validates a phone number (basic international pattern)
  static String? phone(
    String? value, {
    String message = 'Invalid phone number',
  }) {
    if (value == null || value.trim().isEmpty)
      return 'Phone number is required';
    final regex = RegExp(r'^\+?\d{8,15}$');
    if (!regex.hasMatch(value)) {
      return message;
    }
    return null;
  }

  /// Validates that the password meets basic length requirement
  static String? password(String? value, {int minLength = 6, String? message}) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < minLength) {
      return message ?? 'Password must be at least $minLength characters';
    }
    return null;
  }

  /// Confirms that two password fields match
  static String? confirmPassword(
    String? value,
    String? original, {
    String message = 'Passwords do not match',
  }) {
    if (value == null || value != original) {
      return message;
    }
    return null;
  }
}
