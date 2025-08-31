import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/billing.plan.controller.dart';
import 'package:ie_montrac/api/controllers/subscription.controller.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/billing.plan.card.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  static const Color primaryColor = Color(0xff7F3DFF);
  bool isAnnually = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  //handle load data
  void loadData() {
    final billingPlansController = Get.find<BillingPlanController>();
    billingPlansController.getBillingPlans();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BillingPlanController(repository: Get.find<Repository>()),
        builder: (billingPlansController) {
          return GetBuilder(
              init: SubscriptionController(repository: Get.find<Repository>()),
              builder: (subscriptionController) {
                return Stack(
                  children: [
                    AppView(
                      backgroundColor: Colors.white,
                      body: CustomScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: AppColors.primaryColor,
                            title: AppHeaderTitle(
                              title: "Subscriptions",
                              titleColor: Colors.white,
                              iconColor: Colors.white,
                            ),
                          ),
                          SliverFillRemaining(
                            child: ContentContainer(
                              child: RefreshIndicator(
                                  child: Column(
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Pick a plan that fits your financial goals',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    Dimensions.getFontSize(16),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                                height:
                                                    Dimensions.getHeight(10)),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => setState(() =>
                                                        isAnnually = false),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: !isAnnually
                                                            ? primaryColor
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        'Monthly',
                                                        style: TextStyle(
                                                          color: !isAnnually
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[600],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => setState(() =>
                                                        isAnnually = true),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: isAnnually
                                                            ? primaryColor
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Text(
                                                        'Annually',
                                                        style: TextStyle(
                                                          color: isAnnually
                                                              ? Colors.white
                                                              : Colors
                                                                  .grey[600],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(20),
                                            ),
                                          ]),
                                      Expanded(
                                          child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // Pricing Cards
                                            Column(
                                                children: billingPlansController
                                                    .billingPlans
                                                    .map((plan) =>
                                                        BillingPlanCard(
                                                          billingPlan: plan,
                                                          selectedBillingPlan:
                                                              billingPlansController
                                                                  .selectedBillingPlan,
                                                          primaryColor:
                                                              primaryColor,
                                                          isCurrentPlan: false,
                                                          price:
                                                              "GHS ${isAnnually ? plan.yearlyPrice.toStringAsFixed(2) : plan.price.toStringAsFixed(2)}",
                                                          priceSubtext: "",
                                                          onTap: () {
                                                            billingPlansController
                                                                .setSelectedBillingPlan(
                                                                    plan);
                                                          },
                                                          buttonText:
                                                              "Select Plan",
                                                        ))
                                                    .toList()),
                                          ],
                                        ),
                                      )),
                                      SizedBox(
                                        height: Dimensions.getHeight(20),
                                      ),
                                      PrimaryButton(
                                        title: "Continue",
                                        onPressed: () async {
                                          if (billingPlansController
                                                  .selectedBillingPlan !=
                                              null) {
                                            await subscriptionController
                                                .buySubscription(
                                                    billingPlansController
                                                        .selectedBillingPlan!,
                                                    isAnnually);
                                          }
                                        },
                                        disabled: billingPlansController
                                                .selectedBillingPlan ==
                                            null,
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(20),
                                      ),
                                    ],
                                  ),
                                  onRefresh: () async {
                                    await billingPlansController
                                        .getBillingPlans();
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (billingPlansController.loading ||
                        subscriptionController.loading)
                      Loader()
                  ],
                );
              });
        });
  }
}
