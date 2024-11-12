import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class CustomOtpInput extends StatelessWidget {
  final TextEditingController? controller;
  final PinTheme? focusedTheme;
  final PinTheme? submittedTheme;
  final int? length;
  final PinTheme? defaultTheme;
  const CustomOtpInput(
      {super.key,
      this.length,
      this.controller,
      this.defaultTheme,
      this.focusedTheme,
      this.submittedTheme});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: length ?? 6,
      controller: controller,
      separatorBuilder: (index) => SizedBox(width: Dimensions.getWidth(8)),
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultTheme ??
          PinTheme(
              width: Dimensions.getWidth(20),
              height: Dimensions.getWidth(20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(20)))),
      focusedPinTheme: focusedTheme ??
          PinTheme(
            width: Dimensions.getWidth(35),
            height: Dimensions.getWidth(35),
            textStyle: AppFontSize.fontSizeTitle(color: Colors.white),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.getBorderRadius(35)),
                color: AppColors.primaryColor),
          ),
      submittedPinTheme: submittedTheme ??
          PinTheme(
              textStyle: AppFontSize.fontSizeTitle(
                  fontSize: Dimensions.getFontSize(32),
                  fontWeight: FontWeight.w900)),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
