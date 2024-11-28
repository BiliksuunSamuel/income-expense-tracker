import 'package:flutter/material.dart';

import '../theme/app.colors.dart';
import '../utils/dimensions.dart';

class BottomSheetContainer extends StatelessWidget {
  final List<Widget> children;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsets? padding;
  const BottomSheetContainer(
      {super.key,
      required this.children,
      this.backgroundColor,
      this.height,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: padding ?? EdgeInsets.all(Dimensions.getPadding(20)),
        width: const BoxConstraints.expand().maxWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(20)),
            color: backgroundColor ?? Colors.white),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Center(
                child: Container(
                  height: Dimensions.getHeight(4),
                  width: Dimensions.getWidth(30),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.25),
                      borderRadius:
                          BorderRadius.circular(Dimensions.getBorderRadius(8))),
                ),
              ),
              SizedBox(
                height: Dimensions.getHeight(8),
              ),
              ...children
            ])));
  }
}
