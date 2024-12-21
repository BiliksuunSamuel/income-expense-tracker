import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class SvgIcon extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String path;
  final bool? applyColor;
  final Color? contentColor;
  const SvgIcon(
      {super.key,
      required this.path,
      this.height,
      this.width,
      this.color,
      this.applyColor = true,
      this.contentColor});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width ?? Dimensions.getIconSize(22),
      height: height ?? Dimensions.getIconSize(22),
      colorFilter: applyColor != null && applyColor!
          ? ColorFilter.mode(color ?? Colors.white, BlendMode.srcIn)
          : null, // Optional, if you want to colorize the icon
    );
  }
}
