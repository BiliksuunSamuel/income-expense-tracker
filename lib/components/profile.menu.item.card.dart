import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class ProfileMenuItemCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final Color color;
  final Function()? onPress;
  const ProfileMenuItemCard(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.color,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.getHeight(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.getWidth(50),
              height: Dimensions.getHeight(50),
              padding: EdgeInsets.all(Dimensions.getPadding(10)),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(15)),
                  color: color.withOpacity(0.15)),
              child: SvgIcon(
                path: iconPath,
                color: color,
              ),
            ),
            SizedBox(
              width: Dimensions.getWidth(10),
            ),
            Text(
              title,
              style: AppFontSize.fontSizeMedium(),
            )
          ],
        ),
      ),
    );
  }
}
