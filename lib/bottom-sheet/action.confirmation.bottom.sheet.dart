import 'package:flutter/material.dart';
import 'package:ie_montrac/components/bottom.sheet.container.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ActionConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String? message;
  final Function()? onApprove;
  final Function()? onDecline;
  const ActionConfirmationBottomSheet(
      {super.key,
      required this.title,
      this.message,
      this.onApprove,
      this.onDecline});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(children: [
      Center(
        child: Text(
          title,
          style: AppFontSize.fontSizeMedium(fontWeight: FontWeight.w600),
        ),
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      Visibility(
          visible: message != null,
          child: Text(
            message ?? "",
            style: AppFontSize.fontSizeMedium(
                color: Colors.black.withOpacity(0.5)),
            textAlign: TextAlign.center,
          )),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: PrimaryButton(
            title: "No",
            bgcolor: AppColors.primaryColor.withOpacity(0.18),
            textColor: AppColors.primaryDark,
            onPressed: onDecline,
          )),
          SizedBox(
            width: Dimensions.getWidth(15),
          ),
          Expanded(
              child: PrimaryButton(
            title: "Yes",
            onPressed: onApprove,
          ))
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      )
    ]);
  }
}
