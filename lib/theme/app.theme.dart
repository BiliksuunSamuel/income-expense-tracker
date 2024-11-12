import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/theme.color.dart';

import '../utils/dimensions.dart';
import 'app.colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  fontFamily: "Roboto",
  primarySwatch: createMaterialColor(AppColors.primaryColor),
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: Dimensions.getFontSize(96),
      fontWeight: FontWeight.w500,
      letterSpacing: -1.5,
    ),
    displayMedium: TextStyle(
      fontSize: Dimensions.getFontSize(60),
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    displaySmall: TextStyle(
      fontSize: Dimensions.getFontSize(48),
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: TextStyle(
      fontSize: Dimensions.getFontSize(34),
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),
    headlineSmall: TextStyle(
      fontSize: Dimensions.getFontSize(24),
      fontWeight: FontWeight.normal,
    ),
    titleLarge: TextStyle(
      fontSize: Dimensions.getFontSize(24),
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
    ),
    titleMedium: TextStyle(
      fontSize: Dimensions.getFontSize(18),
      fontWeight: FontWeight.normal,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: Dimensions.getFontSize(14),
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontSize: Dimensions.getFontSize(16),
      fontWeight: FontWeight.normal,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: Dimensions.getFontSize(14),
      fontWeight: FontWeight.normal,
      letterSpacing: 0.25,
    ),
    labelLarge: TextStyle(
      fontSize: Dimensions.getFontSize(14),
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    bodySmall: TextStyle(
      fontSize: Dimensions.getFontSize(12),
      fontWeight: FontWeight.normal,
      letterSpacing: 0.4,
    ),
    labelSmall: TextStyle(
      fontSize: Dimensions.getFontSize(10),
      fontWeight: FontWeight.normal,
      letterSpacing: 1.5,
    ),
  ),
);
