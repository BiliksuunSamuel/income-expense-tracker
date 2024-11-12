import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class AppFontSize {
  // Small font size
  static TextStyle fontSizeSmall(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(14),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Medium font size
  static TextStyle fontSizeMedium(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(18),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Label font size
  static TextStyle fontSizeLabel(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(12),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Paragraph font size
  static TextStyle fontSizeParagraph(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(16),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Title font size
  static TextStyle fontSizeTitle(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(20),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Heading font size
  static TextStyle fontSizeHeading(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(28),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Body font size
  static TextStyle fontSizeBody(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(16),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Badge font size
  static TextStyle fontSizeBadge(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(12),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Button font size
  static TextStyle fontSizeButton(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(16),
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Subtitle font size
  static TextStyle fontSizeSubtitle(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(22),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Overline font size
  static TextStyle fontSizeOverline(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(12),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        letterSpacing: 1.5,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }

  // Caption font size
  static TextStyle fontSizeCaption(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      String fontFamily = 'Roboto'}) {
    return TextStyle(
        fontSize: fontSize ?? Dimensions.getFontSize(14),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontFamily: fontFamily);
  }
}
