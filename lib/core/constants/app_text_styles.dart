import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const String _font = 'PlusJakartaSans';

  // Belum konsisten untuk penamaan dan template-nya (menyesuaikan figma saja)
  static const regular11 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textProfileOption,
    fontFamily: _font,
  );

  static const regular12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textProfileOption,
    fontFamily: _font,
  );

  static const regular13 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textProfileOption,
    fontFamily: _font,
  );

  static const regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrayScale60,
    fontFamily: _font,
    // Line height figma: 22 sehingga 22/14
    height: 1.57,
    // Letter spacing figma: 0.5 sehingga 14 * (0.5 / 100)
    letterSpacing: 0.07,
  );

  static const regular15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrayScale60,
    fontFamily: _font,
    height: 1.55,
    // Letter spacing figma: 0%
    letterSpacing: 0,
  );

  static const regular16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textGrayScale90,
    fontFamily: _font,
  );

  static const regular20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontFamily: _font,
    height: 1.5,
  );

  static const medium14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textProfileOption,
    fontFamily: _font,
  );

  static const medium15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textProfileOption,
    fontFamily: _font,
  );

  static const semi12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: _font,
    height: 1.8,
    letterSpacing: 0,
  );

  static const semi14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
    fontFamily: _font,
    // Line height figma: 22 sehingga 22/14
    height: 1.57,
    // Letter spacing figma: 0.5 sehingga 14 * (0.5 / 100)
    letterSpacing: 0.07,
  );

  static const semi15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textProfileOption,
    fontFamily: _font,
    letterSpacing: -0.015, // -1% dari font size 15
  );

  static const semi16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
    fontFamily: _font,
    // Line height figma: 24 sehingga 24/14
    height: 1.5,
    // Letter spacing figma: 0.5 sehingga 16 * (0.5 / 100)
    letterSpacing: 0.08,
  );

  static const semi18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrayScale100,
    fontFamily: _font,
  );

  static const semi20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textProfileOption,
    fontFamily: _font,
  );

  static const bold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    fontFamily: _font,
  );

  static const bold28 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    fontFamily: _font,
  );

  static const bold30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.violet,
    fontFamily: _font,
    height: 1.2, // 120% dari font size 30
  );

  static const extraBold14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: AppColors.textRed,
    fontFamily: _font,
  );
}
