import 'package:flutter/material.dart';
import 'package:ie_montrac/components/custom.dialog.icon.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../enums/dialog.variants.dart';
import '../theme/app.font.size.dart';

class ResponseModal extends StatelessWidget {
  final DialogVariant? variant;
  final String? message;
  const ResponseModal(
      {super.key, this.variant = DialogVariant.Success, this.message});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      children: [
        ContentContainer(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDialogIcon(isError: variant != DialogVariant.Success),
                ],
              ),
              SizedBox(height: Dimensions.getHeight(15)),
              Text(
                message ?? "",
                textAlign: TextAlign.center,
                style: AppFontSize.fontSizeMedium(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.getFontSize(16)),
              )
            ],
          ),
        )
      ],
    );
  }
}
