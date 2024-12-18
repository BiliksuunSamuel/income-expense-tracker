import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class EmptyStateView extends StatelessWidget {
  final double? iconWidth;
  final double? iconHeight;
  final String? message;
  const EmptyStateView(
      {super.key, this.iconHeight, this.message, this.iconWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              path: Resources.empty,
              color: AppColors.textGray,
              width: iconWidth ?? Dimensions.getIconSize(52),
              height: iconHeight ?? Dimensions.getIconSize(52),
            ),
            SizedBox(
              height: Dimensions.getHeight(5),
            ),
            Text(
              message ?? "Nothing to show here!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.withOpacity(0.85),
              ),
            )
          ],
        ),
      ),
    );
  }
}
