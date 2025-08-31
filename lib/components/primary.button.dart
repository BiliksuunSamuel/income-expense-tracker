import 'package:flutter/material.dart';

import '../theme/app.colors.dart';
import '../utils/dimensions.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  final String title;
  Function()? onPressed;
  bool? disabled = false;
  Color? bgcolor;
  Color? textColor;
  PrimaryButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.bgcolor,
      this.textColor,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: const BoxConstraints.expand().maxWidth,
      child: ElevatedButton(
          onPressed: disabled! ? null : onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.getPadding(16),
                vertical: Dimensions.getPadding(15)),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.getBorderRadius(15)),
            ),
            backgroundColor: disabled!
                ? Colors.grey.withValues(alpha: 0.28)
                : bgcolor ?? AppColors.primaryColor,
            //give button order
            side: BorderSide(
              color: disabled!
                  ? Colors.grey.withValues(alpha: 0.28)
                  : bgcolor ?? AppColors.primaryColor,
              width: Dimensions.getWidth(1),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
                color: disabled! ? Colors.grey : textColor ?? Colors.white,
                fontSize: Dimensions.getFontSize(18),
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
