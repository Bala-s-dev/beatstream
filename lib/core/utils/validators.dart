/// Centralized, reusable form validators.
///
/// Kept pure (no BuildContext / widget dependency) so they are trivially
/// unit-testable and reusable across every form in the app.
abstract final class Validators {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]"
    r"(?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?"
    r"(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
  );

  // Matches +1 (555) 000-0000, +91 9876543210, 9876543210, etc.
  static final RegExp _phoneRegExp = RegExp(r'^[+]?[\d\s()-]{7,20}$');

  static String? email(String? value) {
    final String trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Email address is required';
    if (!_emailRegExp.hasMatch(trimmed)) return 'Enter a valid email address';
    return null;
  }

  static String? password(String? value) {
    final String v = value ?? '';
    if (v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'Password must be at least 8 characters';
    final bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(v);
    final bool hasDigit = RegExp(r'\d').hasMatch(v);
    if (!hasLetter || !hasDigit) {
      return 'Use a mix of letters and numbers';
    }
    return null;
  }

  /// Lighter-weight check for login (we don't want to punish existing users
  /// whose passwords predate the stricter registration policy).
  static String? loginPassword(String? value) {
    final String v = value ?? '';
    if (v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? confirmPassword(String? value, String? original) {
    final String v = value ?? '';
    if (v.isEmpty) return 'Please confirm your password';
    if (v != original) return 'Passwords do not match';
    return null;
  }

  static String? fullName(String? value) {
    final String trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Full name is required';
    if (trimmed.length < 2) return 'Name is too short';
    if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(trimmed)) {
      return 'Name contains invalid characters';
    }
    return null;
  }

  static String? phone(String? value) {
    final String trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return 'Phone number is required';
    if (!_phoneRegExp.hasMatch(trimmed)) return 'Enter a valid phone number';
    final digitsOnly = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 7) return 'Phone number is too short';
    return null;
  }

  static String? required(String? value, {String field = 'This field'}) {
    if ((value ?? '').trim().isEmpty) return '$field is required';
    return null;
  }
}
