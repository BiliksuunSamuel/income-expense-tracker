import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';

import '../helper/resources.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class FilePickerButton extends StatelessWidget {
  final Function()? onPress;
  const FilePickerButton({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: Dimensions.getHeight(50),
        padding: EdgeInsets.all(Dimensions.getPadding(8)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(12)),
            border: Border.all(
                width: Dimensions.getWidth(0.35),
                color: Colors.grey.withOpacity(0.85))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              path: Resources.attachment,
              width: Dimensions.getWidth(16),
              height: Dimensions.getWidth(16),
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(
              width: Dimensions.getWidth(10),
            ),
            Text(
              "Add Attachment",
              style: AppFontSize.fontSizeTitle(
                  fontSize: Dimensions.getFontSize(16), color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
