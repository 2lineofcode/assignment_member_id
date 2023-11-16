import 'package:flutter/material.dart';

mixin AppTheme {
  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      /// appbar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.appbarColor,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),

      /// scaffold
      scaffoldBackgroundColor: Color(0xFF111D3E),

      /// text
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 16, height: 1.4),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4),
        displayLarge: TextStyle(fontSize: 18, height: 1.4),
        displayMedium: TextStyle(fontSize: 18, height: 1.4),
        bodySmall: TextStyle(fontSize: 12, height: 1.4),
        labelSmall: TextStyle(),
      ),

      /// elevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.buttonColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        ),
      ),

      /// outlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
            side: BorderSide(color: AppColor.buttonColor),
          ),
        ),
      ),
    );
  }
}

/// colors
mixin AppColor {
  static final appbarColor = Color.fromARGB(255, 30, 51, 109);
  static final buttonColor = Color(0xFF2298BF);
  static final cardColor = Color(0xFF142454);
}
