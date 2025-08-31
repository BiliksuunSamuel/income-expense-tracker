import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/models/subscription.dart';
import 'package:ie_montrac/routes/app.routes.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../api/controllers/subscription.controller.dart';
import '../../components/billing.plan.item.dart';
import '../../utils/utilities.dart';

class SubscriptionDetailsScreen extends StatefulWidget {
  const SubscriptionDetailsScreen({super.key});

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      loadData();
    });
  }

  //handle load data
  void loadData() async {
    var args = Get.arguments['subscription'];
    if (args != null) {
      var subscriptionController = Get.find<SubscriptionController>();
      var sub = Subscription.fromJson(args);
      subscriptionController.setSubscription(sub);
      getSubscription(sub.id ?? "");
    }
  }

  //handle refresh
  Future<void> onRefresh(String id) async {
    var controller = Get.find<SubscriptionController>();
    await controller.getSubscriptionById(id);
  }

  //handle get subscription
  void getSubscription(String id) async {
    var controller = Get.find<SubscriptionController>();
    await controller.getSubscriptionById(id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SubscriptionController(repository: Get.find()),
        builder: (controller) {
          var subscription = controller.subscription;
          return Stack(
            children: [
              RefreshIndicator(
                  child: AppView(
                    backgroundColor: AppColors.bodyBackgroundColor,
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                            pinned: true,
                            backgroundColor: AppColors.bodyBackgroundColor,
                            elevation: 0,
                            automaticallyImplyLeading: false,
                            title: AppHeaderTitle(
                              title: "Subscription Details",
                            )),
                        SliverFillRemaining(
                          child: subscription == null
                              ? EmptyStateView()
                              : ContentContainer(
                                  backgroundColor:
                                      AppColors.bodyBackgroundColor,
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subscription.planTitle ?? "",
                                            style: AppFontSize.fontSizeMedium(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Dimensions.getFontSize(24)),
                                          ),
                                          SizedBox(
                                            height: Dimensions.getHeight(8),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Dimensions.getWidth(8),
                                                vertical:
                                                    Dimensions.getHeight(4)),
                                            decoration: BoxDecoration(
                                                color: subscription.isActive
                                                    ? AppColors.primaryColor
                                                        .withValues(alpha: 0.25)
                                                    : AppColors.redColor
                                                        .withValues(
                                                            alpha: 0.25),
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                        .getBorderRadius(20))),
                                            child: Text(
                                              subscription.isActive
                                                  ? "Active"
                                                  : "Inactive",
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
                                        subscription.plan?.description ?? "",
                                        style: AppFontSize.fontSizeBody(
                                            color: AppColors.textGray,
                                            fontSize:
                                                Dimensions.getFontSize(18)),
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(20),
                                      ),
                                      Column(
                                        children: [
                                          ...subscription.plan!.features.map(
                                            (feature) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 2),
                                              child: BillingPlanItem(
                                                feature: feature,
                                                isAvailable: true,
                                                primaryColor:
                                                    AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          if (subscription
                                              .plan!
                                              .unavailableFeatures
                                              .isNotEmpty) ...[
                                            const SizedBox(height: 8),
                                            Divider(
                                                color: Colors.grey[200],
                                                thickness: 1),
                                            const SizedBox(height: 8),
                                            ...subscription
                                                .plan!.unavailableFeatures
                                                .map(
                                              (feature) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2),
                                                child: BillingPlanItem(
                                                  feature: feature,
                                                  isAvailable: false,
                                                  primaryColor:
                                                      AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],

                                          // Subscription Expiry Section
                                          SizedBox(
                                            height: Dimensions.getHeight(20),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(
                                                Dimensions.getWidth(15)),
                                            decoration: BoxDecoration(
                                                color: subscription!.isActive
                                                    ? AppColors.primaryColor
                                                        .withValues(alpha: 0.1)
                                                    : AppColors.redColor
                                                        .withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(
                                                    Dimensions.getWidth(10)),
                                                border: BoxBorder.fromLTRB(
                                                    top: BorderSide(
                                                        width:
                                                            Dimensions.getWidth(
                                                                2),
                                                        color: subscription!
                                                                .isActive
                                                            ? AppColors
                                                                .primaryColor
                                                            : AppColors
                                                                .redColor),
                                                    bottom: BorderSide(width: Dimensions.getWidth(0.25), color: subscription!.isActive ? AppColors.primaryColor : AppColors.redColor),
                                                    right: BorderSide(width: Dimensions.getWidth(0.25), color: subscription!.isActive ? AppColors.primaryColor : AppColors.redColor),
                                                    left: BorderSide(width: Dimensions.getWidth(0.25), color: subscription!.isActive ? AppColors.primaryColor : AppColors.redColor))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.getWidth(8)),
                                                  decoration: BoxDecoration(
                                                      color: subscription!.isActive
                                                          ? AppColors.primaryColor
                                                              .withValues(
                                                                  alpha: 0.25)
                                                          : AppColors.redColor
                                                              .withValues(
                                                                  alpha: 0.25),
                                                      border: Border.all(
                                                          width: Dimensions
                                                              .getWidth(0.5),
                                                          color: AppColors
                                                              .primaryColor
                                                              .withValues(
                                                                  alpha: 0.5)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions.getBorderRadius(10))),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch, // This makes it take full width
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.schedule,
                                                              size: Dimensions
                                                                  .getIconSize(
                                                                      18),
                                                              color: subscription!
                                                                      .isActive
                                                                  ? AppColors
                                                                      .primaryColor
                                                                  : AppColors
                                                                      .redColor),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .getWidth(4)),
                                                          Text(
                                                            subscription!
                                                                    .isActive
                                                                ? "Expires On:"
                                                                : "Expired On:",
                                                            style: AppFontSize.fontSizeSmall(
                                                                color: subscription!
                                                                        .isActive
                                                                    ? AppColors
                                                                        .primaryColor
                                                                    : AppColors
                                                                        .redColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions.getWidth(
                                                            5), // Should be height, not width
                                                      ),
                                                      Text(
                                                        longDateString(
                                                            subscription!
                                                                .endDate),
                                                        style: AppFontSize
                                                            .fontSizeMedium(
                                                                fontSize: Dimensions
                                                                    .getFontSize(
                                                                        16),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          //CTA Section
                                          SizedBox(
                                            height: Dimensions.getHeight(20),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: PrimaryButton(
                                                      title: subscription
                                                                  .isActive ==
                                                              true
                                                          ? "Upgrade"
                                                          : "Renew Now",
                                                      onPressed: () {
                                                        Get.toNamed(AppRoutes
                                                            .subscriptionsScreen);
                                                      })),
                                              SizedBox(
                                                width: Dimensions.getWidth(10),
                                              ),
                                              Expanded(
                                                  child: PrimaryButton(
                                                title: "Manage",
                                                bgcolor: AppColors.primaryDark
                                                    .withValues(alpha: 0.15),
                                                textColor:
                                                    AppColors.primaryDark,
                                              ))
                                            ],
                                          ),
                                          //Note Section
                                          SizedBox(
                                            height: Dimensions.getHeight(10),
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            thickness: 1,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Need help with your subscription?",
                                                  style: AppFontSize
                                                      .fontSizeSmall()),
                                              SizedBox(
                                                height: Dimensions.getHeight(4),
                                              ),
                                              Text(
                                                "Contact our support",
                                                style:
                                                    AppFontSize.fontSizeSmall(
                                                        color: AppColors
                                                            .primaryDark,
                                                        fontSize: Dimensions
                                                            .getFontSize(16),
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(20),
                                      )
                                    ],
                                  ),
                                ),
                        )
                      ],
                    ),
                  ),
                  onRefresh: () async {
                    if (controller.subscription != null) {
                      onRefresh(controller.subscription!.id ?? "");
                    }
                  }),
              if (controller.loading) const Loader()
            ],
          );
        });
  }
}
