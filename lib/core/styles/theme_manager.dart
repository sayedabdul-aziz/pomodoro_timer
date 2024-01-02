import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/styles/app_color.dart';
import 'package:pomodoro_timer/core/styles/styles_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
      // appbar theme
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.focusBackgroundColor, elevation: 0.0),

      // floatingActionButtonTheme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(30))),

      // inputDecoration Theme
      inputDecorationTheme: InputDecorationTheme(
        suffixStyle:
            getRegularStyle(color: AppColors.focusTextColor, fontSize: 12),
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.focusTextColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.focusTextColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red)),
      ));
}
