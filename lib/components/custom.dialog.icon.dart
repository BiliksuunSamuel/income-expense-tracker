import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.colors.dart';

import '../utils/dimensions.dart';

class CustomDialogIcon extends StatelessWidget {
  final bool isError;
  const CustomDialogIcon({super.key, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.getWidth(45),
      height: Dimensions.getWidth(45),
      decoration: BoxDecoration(
          color: isError ? AppColors.redColor : AppColors.primaryDark,
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(100))),
      child: Center(
        child: Icon(
          isError ? Icons.close : Icons.check,
          color: Colors.white,
          size: Dimensions.getIconSize(28),
        ),
      ),
    );
  }
}
