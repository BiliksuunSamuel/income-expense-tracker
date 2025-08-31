import 'package:flutter/material.dart';
import 'package:ie_montrac/models/subscription.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';
import '../utils/utilities.dart';

class ActiveSubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final Function() onTap;
  const ActiveSubscriptionCard(
      {super.key, required this.subscription, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Dimensions.getWidth(15)),
        decoration: BoxDecoration(
            color: subscription.isActive
                ? AppColors.primaryColor.withValues(alpha: 0.1)
                : AppColors.redColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Dimensions.getWidth(10)),
            border: BoxBorder.fromLTRB(
                top: BorderSide(
                    width: Dimensions.getWidth(2),
                    color: subscription.isActive
                        ? AppColors.primaryColor
                        : AppColors.redColor),
                bottom: BorderSide(
                    width: Dimensions.getWidth(0.25),
                    color: subscription.isActive
                        ? AppColors.primaryColor
                        : AppColors.redColor),
                right: BorderSide(
                    width: Dimensions.getWidth(0.25),
                    color: subscription.isActive
                        ? AppColors.primaryColor
                        : AppColors.redColor),
                left: BorderSide(
                    width: Dimensions.getWidth(0.25),
                    color: subscription.isActive
                        ? AppColors.primaryColor
                        : AppColors.redColor))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  subscription.planTitle,
                  style: AppFontSize.fontSizeMedium(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.getWidth(8),
                      vertical: Dimensions.getHeight(4)),
                  decoration: BoxDecoration(
                      color: subscription.isActive
                          ? AppColors.primaryColor.withValues(alpha: 0.25)
                          : AppColors.redColor.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(
                          Dimensions.getBorderRadius(20))),
                  child: Text(
                    subscription.isActive ? "Active" : "Inactive",
                    style: AppFontSize.fontSizeSmall(
                        color: subscription.isActive
                            ? AppColors.primaryColor
                            : AppColors.redColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.getHeight(10),
            ),
            Text(
              subscription.plan!.description,
              style: AppFontSize.fontSizeBody(
                  color: AppColors.textGray,
                  fontSize: Dimensions.getFontSize(14)),
            ),
            SizedBox(
              height: Dimensions.getHeight(8),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.getWidth(8)),
              decoration: BoxDecoration(
                  color: subscription.isActive
                      ? AppColors.primaryColor.withValues(alpha: 0.25)
                      : AppColors.redColor.withValues(alpha: 0.25),
                  border: Border.all(
                      width: Dimensions.getWidth(0.5),
                      color: AppColors.primaryColor.withValues(alpha: 0.5)),
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(10))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // This makes it take full width
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule,
                          size: Dimensions.getIconSize(20),
                          color: subscription.isActive
                              ? AppColors.primaryColor
                              : AppColors.redColor),
                      SizedBox(width: Dimensions.getWidth(4)),
                      Text(
                        subscription.isActive ? "Expires On:" : "Expired On:",
                        style: AppFontSize.fontSizeSmall(
                            color: subscription.isActive
                                ? AppColors.primaryColor
                                : AppColors.redColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        Dimensions.getWidth(5), // Should be height, not width
                  ),
                  Text(
                    longDateString(subscription.endDate),
                    style: AppFontSize.fontSizeMedium(
                        fontSize: Dimensions.getFontSize(16),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
