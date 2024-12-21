import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/models/budget.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/utils/utilities.dart';

class BudgetCard extends StatelessWidget {
  final Function()? onPress;
  final Budget budget;
  final String currency;
  const BudgetCard(
      {super.key, this.onPress, required this.budget, required this.currency});

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
                          color: mapCategoryToColor(budget.category),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.getWidth(5),
                      ),
                      Flexible(
                        // Use Flexible instead of Expanded
                        child: Text(
                          budget.category.trim(),
                          style: AppFontSize.fontSizeMedium(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Dimensions.getWidth(10),
                ),
                Visibility(
                  visible: budget.limitExceeded,
                  child: const SvgIcon(
                    path: Resources.warning,
                    color: AppColors.redColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            Text(
              budget.title,
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
                  value: budget.progressValue / budget.amount,
                  color: mapCategoryToColor(budget.category),
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "$currency ${budget.progressValue} of $currency ${budget.amount}",
                  style: AppFontSize.fontSizeMedium(
                    color: AppColors.textGray,
                  ),
                )),
                Container(
                  width: Dimensions.getWidth(28),
                  height: Dimensions.getWidth(28),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Active".equals(budget.status)
                          ? Resources.openedImg
                          : Resources.closedImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(5),
            ),
            Visibility(
                visible: budget.limitExceeded,
                child: Text(
                  "You've exceeded the limit",
                  style: AppFontSize.fontSizeSmall(color: AppColors.redColor),
                )),
          ],
        ),
      ),
    );
  }
}
