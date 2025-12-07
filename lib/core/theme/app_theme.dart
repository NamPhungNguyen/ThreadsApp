import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.primaryDart,
        onSurface: AppColors.primaryDart,
        surfaceContainerHighest: AppColors.primaryDart,
        surface: AppColors.primaryLight,
        outline: AppColors.border,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: AppColors.hintText,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: AppColors.primaryLight,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDart,
        onPrimary: AppColors.primaryLight,
        onSurface: AppColors.primaryLight,
        surfaceContainerHighest: AppColors.primaryLight,
        surface: AppColors.primaryDart,
        outline: AppColors.borderDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.hintText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor: AppColors.primaryDart,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.borderDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.borderDark,
          ),
        ),
      ),
    );
  }
}

extension GradientTheme on ThemeData {
  LinearGradient get loginBackgroundGradient {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFFFFFF), // Light blue
        Color(0xFFFAEDFF), // Light purple
        Color(0xFFEAF6FF), // Light yellow
        Color(0xFFE5FFED), // Light cyan
      ],
      stops: [0.0, 0.2, 0.4, 1.0],
    );
  }
}
