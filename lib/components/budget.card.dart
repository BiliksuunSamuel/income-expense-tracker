import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class BudgetCard extends StatelessWidget {
  final Function()? onPress;
  const BudgetCard({super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.getHeight(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getPadding(10),
                      vertical: Dimensions.getPadding(5)),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.getBorderRadius(20)),
                    border: Border.all(
                      width: Dimensions.getWidth(0.15),
                      color: AppColors.textGray,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize:
                        MainAxisSize.min, // Ensure the row wraps its content
                    children: [
                      Container(
                        width: Dimensions.getWidth(15),
                        height: Dimensions.getWidth(15),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.getWidth(100)),
                          color: AppColors.orangeColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(5),
                      ),
                      Flexible(
                        // Use Flexible instead of Expanded
                        child: Text(
                          "Shopping",
                          style: AppFontSize.fontSizeMedium(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Dimensions.getWidth(10),
                ),
                const SvgIcon(
                  path: Resources.warning,
                  color: AppColors.redColor,
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            Text(
              "Remaining \$0",
              style: AppFontSize.fontSizeTitle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.getFontSize(24),
              ),
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  Dimensions.getBorderRadius(20),
                ),
                child: LinearProgressIndicator(
                  value: 0.6,
                  color: AppColors.orangeColor,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            Text(
              "\$1200 of \$1000",
              style: AppFontSize.fontSizeMedium(
                color: AppColors.textGray,
              ),
            ),
            SizedBox(
              height: Dimensions.getHeight(5),
            ),
            Text(
              "You've exceeded the limit",
              style: AppFontSize.fontSizeSmall(color: AppColors.redColor),
            ),
          ],
        ),
      ),
    );
  }
}
