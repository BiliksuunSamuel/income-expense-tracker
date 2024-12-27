import 'package:flutter/material.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class LinkButton extends StatelessWidget {
  final String? title;
  final Function()? onPress;
  final Color? color;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final double? fontSize;
  const LinkButton(
      {super.key,
      this.title,
      this.decoration,
      this.onPress,
      this.color,
      this.fontWeight,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Text(
              title ?? "click me",
              style: AppFontSize.fontSizeMedium(
                      color: color ?? AppColors.primaryColor,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      fontSize: fontSize ?? Dimensions.getFontSize(18))
                  .copyWith(
                      decorationColor: color ?? AppColors.primaryColor,
                      decorationThickness: Dimensions.getHeight(2)),
            ),
            Visibility(
                visible: decoration != TextDecoration.none,
                child: Positioned(
                  bottom: 0, // Adjust this value for more or less spacing
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2, // Thickness of the underline
                    color: AppColors.primaryColor, // Color of the underline
                  ),
                )),
          ],
        ));
  }
}
