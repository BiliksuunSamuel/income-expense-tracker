import 'package:flutter/material.dart';

class Dimensions {
  static const referenceHeight = 812.0;
  static const referenceWidth = 375.0;
  static double deviceWidth = 0;
  static double deviceHeight = 0;

  static void init(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    if (deviceWidth < 1) {
      deviceWidth = referenceWidth;
    }
    if (deviceHeight < 1) {
      deviceHeight = referenceHeight;
    }
  }

  /// Scale by height based on the reference height
  static double getHeight(double size) {
    return (size / referenceHeight) * deviceHeight;
  }

  /// Scale by width based on the reference width
  static double getWidth(double size) {
    return (size / referenceWidth) * deviceWidth;
  }

  /// Scale font size proportionally using width
  static double getFontSize(double fontSize) {
    return getWidth(fontSize);
  }

  /// Scale margin proportionally using width
  static double getMargin(double margin) {
    return getWidth(margin);
  }

  /// Scale padding proportionally using width
  static double getPadding(double padding) {
    return getWidth(padding);
  }

  /// Scale border radius proportionally using width
  static double getBorderRadius(double borderRadius) {
    return getWidth(borderRadius);
  }

  /// Scale icon size proportionally using width
  static double getIconSize(double iconSize) {
    return getWidth(iconSize);
  }

  /// Scale letter spacing proportionally using width
  static double getLetterSpacing(double letterSpacing) {
    return getWidth(letterSpacing);
  }

  /// Scale line height proportionally using width
  static double getLineHeight(double lineHeight) {
    return getWidth(lineHeight);
  }

  /// Scale elevation proportionally using width
  static double getElevation(double elevation) {
    return getWidth(elevation);
  }

  /// Scale box shadow proportionally using width
  static double getBoxShadow(double boxShadow) {
    return getWidth(boxShadow);
  }

  /// Scale blur radius proportionally using width
  static double getBlurRadius(double blurRadius) {
    return getWidth(blurRadius);
  }

  /// Scale spread radius proportionally using width
  static double getSpreadRadius(double spreadRadius) {
    return getWidth(spreadRadius);
  }

  /// Scale offset proportionally using width
  static double getOffset(double offset) {
    return getWidth(offset);
  }

  /// Scale radius proportionally using width
  static double getRadius(double radius) {
    return getWidth(radius);
  }

  /// Scale top offset proportionally using height
  static double getTop(double top) {
    return getHeight(top);
  }

  /// Scale bottom offset proportionally using height
  static double getBottom(double bottom) {
    return getHeight(bottom);
  }

  /// Scale left offset proportionally using width
  static double getLeft(double left) {
    return getWidth(left);
  }

  /// Scale right offset proportionally using width
  static double getRight(double right) {
    return getWidth(right);
  }

  /// Scale horizontal offset proportionally using width
  static double getHorizontal(double horizontal) {
    return getWidth(horizontal);
  }

  /// Scale vertical offset proportionally using height
  static double getVertical(double vertical) {
    return getHeight(vertical);
  }
}
