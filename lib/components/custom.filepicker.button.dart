import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

import '../theme/app.colors.dart';

class CustomFilePickerButton extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color? iconColor;
  final Color? titleColor;
  final Function()? onPress;
  const CustomFilePickerButton(
      {super.key,
      required this.title,
      required this.iconPath,
      this.iconColor,
      this.titleColor,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: Dimensions.getHeight(95),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(5)),
        padding: EdgeInsets.all(Dimensions.getPadding(10)),
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.15),
            borderRadius:
                BorderRadius.circular(Dimensions.getBorderRadius(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              path: iconPath,
              color: iconColor ?? AppColors.primaryColor,
              width: Dimensions.getIconSize(28),
              height: Dimensions.getIconSize(28),
            ),
            SizedBox(
              height: Dimensions.getHeight(5),
            ),
            Text(
              title,
              style: AppFontSize.fontSizeTitle(
                  fontSize: Dimensions.getFontSize(16),
                  color: titleColor ?? AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
