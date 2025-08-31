import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/models/subscription.dart';
import 'package:ie_montrac/routes/app.routes.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class SubscriptionNoticeBadge extends StatelessWidget {
  final Subscription? subscription;
  const SubscriptionNoticeBadge({super.key, this.subscription});

  @override
  Widget build(BuildContext context) {
    return subscription != null && subscription!.isActive
        ? SizedBox()
        : GestureDetector(
            onTap: () {
              subscription != null
                  ? Get.toNamed(AppRoutes.subscriptionDetailsScreen,
                      arguments: {"subscription": subscription!.toJson()})
                  : Get.toNamed(AppRoutes.subscriptionsScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.getPadding(15),
              ),
              child: Container(
                padding: EdgeInsets.all(Dimensions.getPadding(8)),
                decoration: BoxDecoration(
                    color: subscription?.isActive == true
                        ? AppColors.primaryColor.withValues(alpha: 0.15)
                        : AppColors.redColor.withValues(alpha: 0.15),
                    borderRadius:
                        BorderRadius.circular(Dimensions.getBorderRadius(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: subscription?.isActive == true
                          ? AppColors.primaryColor
                          : AppColors.redColor,
                    ),
                    SizedBox(
                      width: Dimensions.getWidth(8),
                    ),
                    Expanded(
                        child: Text(
                            subscription?.isActive == true
                                ? ""
                                : subscription == null
                                    ? "Purchase Subscription"
                                    : "Subscription Expired",
                            style: AppFontSize.fontSizeMedium(
                                color: subscription?.isActive == true
                                    ? AppColors.primaryColor
                                    : AppColors.redColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16))),
                    SizedBox(
                      width: Dimensions.getWidth(10),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: subscription?.isActive == true
                          ? AppColors.primaryColor
                          : AppColors.redColor,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
