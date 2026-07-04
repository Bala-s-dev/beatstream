import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static TextStyle get _base => GoogleFonts.hankenGrotesk();

  /// 32px / 700 / -0.02em letter spacing / 40px line height.
  static TextStyle displayLg({Color color = AppColors.onSurface}) =>
      _base.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02 * 32,
        height: 40 / 32,
        color: color,
      );

  /// 20px / 600 / 28px line height.
  static TextStyle headlineMd({Color color = AppColors.onSurface}) =>
      _base.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 28 / 20,
        color: color,
      );

  /// 16px / 500 / 24px line height.
  static TextStyle bodyLg({Color color = AppColors.onSurface}) =>
      _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 24 / 16,
        color: color,
      );

  /// 14px / 400 / 20px line height.
  static TextStyle bodyMd({Color color = AppColors.onSurface}) =>
      _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: color,
      );

  /// 12px / 600 / uppercase-tracking / 16px line height.
  static TextStyle labelSm({Color color = AppColors.onSurface}) =>
      _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05 * 12,
        height: 16 / 12,
        color: color,
      );
}
