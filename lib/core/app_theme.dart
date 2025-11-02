import 'package:flutter/material.dart';

class AppTheme {
  AppTheme();

  static const Color primaryColor = Color(0xFF004182);
  static const Color secondaryColor = Color(0xFF06004F);
  static const Color white = Color(0xFFF5F5F5);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: primaryColor,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: secondaryColor,
      indicatorColor: primaryColor,
      iconTheme: WidgetStateProperty.all(IconThemeData(color: white, size: 20)),
    ),
    primaryColor: primaryColor,

    textTheme: TextTheme(
      bodySmall: TextStyle(color: white, fontSize: 16),
      bodyMedium: TextStyle(color: white, fontSize: 18),
      bodyLarge: TextStyle(color: white, fontSize: 24),
    ),
  );

  static final ThemeData darkTheme = ThemeData();
}
