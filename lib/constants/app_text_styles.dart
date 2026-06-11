import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _font = 'Cairo';

  static const TextStyle appTitle = TextStyle(
    fontFamily: _font, fontSize: 40,
    fontWeight: FontWeight.bold, color: AppColors.primary,
  );
  static const TextStyle appSubtitle = TextStyle(
    fontFamily: _font, fontSize: 15, color: AppColors.textMedium,
  );
  static const TextStyle heading1 = TextStyle(
    fontFamily: _font, fontSize: 24,
    fontWeight: FontWeight.bold, color: AppColors.textDark,
  );
  static const TextStyle heading2 = TextStyle(
    fontFamily: _font, fontSize: 20,
    fontWeight: FontWeight.bold, color: AppColors.textDark,
  );
  static const TextStyle heading3 = TextStyle(
    fontFamily: _font, fontSize: 16,
    fontWeight: FontWeight.w600, color: AppColors.textDark,
  );
  static const TextStyle body = TextStyle(
    fontFamily: _font, fontSize: 15, color: AppColors.textDark,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font, fontSize: 14, color: AppColors.textMedium,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _font, fontSize: 12, color: AppColors.textLight,
  );
  static const TextStyle button = TextStyle(
    fontFamily: _font, fontSize: 17,
    fontWeight: FontWeight.bold, color: AppColors.white,
  );
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: _font, fontSize: 20,
    fontWeight: FontWeight.bold, color: AppColors.white,
  );
  static const TextStyle doctorName = TextStyle(
    fontFamily: _font, fontSize: 17,
    fontWeight: FontWeight.bold, color: AppColors.accent,
  );
  static const TextStyle specialtyLabel = TextStyle(
    fontFamily: _font, fontSize: 13,
    fontWeight: FontWeight.w500, color: AppColors.textMedium,
  );
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: _font, fontSize: 17,
    fontWeight: FontWeight.bold, color: AppColors.textDark,
  );
  static const TextStyle greetingName = TextStyle(
    fontFamily: _font, fontSize: 17,
    fontWeight: FontWeight.bold, color: AppColors.textDark,
  );
  static const TextStyle greetingSub = TextStyle(
    fontFamily: _font, fontSize: 13, color: AppColors.textMedium,
  );
  static const TextStyle medicalLabel = TextStyle(
    fontFamily: _font, fontSize: 13, color: AppColors.textMedium,
  );
  static const TextStyle medicalValue = TextStyle(
    fontFamily: _font, fontSize: 14,
    fontWeight: FontWeight.bold, color: AppColors.textDark,
  );
  static const TextStyle profileName = TextStyle(
    fontFamily: _font, fontSize: 22,
    fontWeight: FontWeight.bold, color: AppColors.textDark,
  );
  static const TextStyle timeText = TextStyle(
    fontFamily: _font, fontSize: 16,
    fontWeight: FontWeight.bold, color: AppColors.white,
  );
  static const TextStyle statusUpcoming = TextStyle(
    fontFamily: _font, fontSize: 12,
    fontWeight: FontWeight.bold, color: AppColors.statusUpcoming,
  );
  static const TextStyle statusCompleted = TextStyle(
    fontFamily: _font, fontSize: 12,
    fontWeight: FontWeight.bold, color: AppColors.statusCompleted,
  );
  static const TextStyle statusCancelled = TextStyle(
    fontFamily: _font, fontSize: 12,
    fontWeight: FontWeight.bold, color: AppColors.statusCancelled,
  );
}
