import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.colors.dart';

import '../utils/dimensions.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final InputDecoration? decoration;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? minLines;
  final int? maxLines;
  const CustomInput(
      {super.key,
      this.controller,
      this.hintText,
      this.label,
      this.keyboardType,
      this.obscureText = false,
      this.decoration,
      this.style,
      this.prefixIcon,
      this.suffixIcon,
      this.minLines = 1,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: const BoxConstraints.expand().maxWidth,
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        style: style ?? TextStyle(fontSize: Dimensions.getFontSize(18)),
        maxLines: maxLines,
        minLines: minLines,
        decoration: decoration ??
            InputDecoration(
                label: label != null ? Text(label!) : null,
                hintText: hintText ?? label,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getPadding(16),
                    vertical: Dimensions.getPadding(12)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: Dimensions.getWidth(0.35), color: Colors.grey),
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(15)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: Dimensions.getWidth(0.35), color: Colors.grey),
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(15)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: Dimensions.getWidth(0.85),
                        color: AppColors.primaryColor),
                    borderRadius:
                        BorderRadius.circular(Dimensions.getBorderRadius(15))),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon),
      ),
    );
  }
}
