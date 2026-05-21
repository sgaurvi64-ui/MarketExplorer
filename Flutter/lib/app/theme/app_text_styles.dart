import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );

  static const headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.dark,
  );

  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.muted,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );
}
