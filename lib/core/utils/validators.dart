class Validators {
  // ✅ Email Validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  // ✅ Password Validation
  // - At least 8 chars
  // - At least 1 uppercase, 1 lowercase, 1 number, 1 special char
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    if (!passwordRegex.hasMatch(value)) {
      return "Password must be 8+ chars, include upper, lower, number & symbol";
    }
    return null;
  }

  // ✅ Full Name Validation
  // - Only letters + spaces
  // - At least 2 words
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return "Full name is required";
    }
    final nameRegex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)+$');
    if (!nameRegex.hasMatch(value.trim())) {
      return "Enter your full name (first & last)";
    }
    return null;
  }

  // ✅ Phone Number Validation
  // - Digits only
  // - 10 to 15 digits
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    final phoneRegex = RegExp(r'^\d{10,15}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid phone number (10-15 digits)";
    }
    return null;
  }
}
