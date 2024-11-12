import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class AppHeaderTitle extends StatelessWidget {
  final Function()? handleBackButtonPressed;
  final String? title;
  final Widget? rightComponent;
  final Color? titleColor;
  final Color? iconColor;
  const AppHeaderTitle(
      {super.key,
      this.handleBackButtonPressed,
      this.title,
      this.rightComponent,
      this.iconColor,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: handleBackButtonPressed ??
                  () {
                    Get.back();
                  },
              icon: Icon(
                Icons.arrow_back_outlined,
                color: iconColor ?? Colors.black,
              )),
          SizedBox(width: Dimensions.getWidth(10)),
          Expanded(
            child: Text(title ?? "Title Here",
                textAlign: TextAlign.center,
                style: AppFontSize.fontSizeTitle(
                  color: titleColor ?? Colors.black,
                  fontWeight: FontWeight.bold,
                )),
          ),
          SizedBox(width: Dimensions.getWidth(8)),
          Visibility(
              visible: rightComponent != null,
              child: rightComponent ?? Container())
        ],
      ),
    );
  }
}
