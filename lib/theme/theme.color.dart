import 'package:flutter/material.dart';

/// Helper function to create a [MaterialColor] from a base color
MaterialColor createMaterialColor(Color color) {
  final Map<int, Color> swatch = {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  };
  return MaterialColor(color.value, swatch);
}

/// Lightens the [color] by the given [factor].
Color _tintColor(Color color, double factor) => Color.fromRGBO(
      color.red + ((255 - color.red) * factor).round(),
      color.green + ((255 - color.green) * factor).round(),
      color.blue + ((255 - color.blue) * factor).round(),
      1,
    );

/// Darkens the [color] by the given [factor].
Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      (color.red * (1 - factor)).round(),
      (color.green * (1 - factor)).round(),
      (color.blue * (1 - factor)).round(),
      1,
    );
