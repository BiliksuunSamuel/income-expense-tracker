import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/controllers/transaction.controller.dart';
import 'package:ie_montrac/components/subscription.notice.badge.dart';
import 'package:ie_montrac/views/app.view.dart';

import '../../api/repositories/repository.dart';
import '../../chart/spend.frequency.chart.dart';
import '../../components/loader.dart';
import '../../components/svg.icon.dart';
import '../../helper/expense.tracker.dart';
import '../../theme/app.colors.dart';
import '../../theme/app.font.size.dart';
import '../../utils/dimensions.dart';
import '../../views/income.expense.summary.view.dart';
import '../../views/recent.transactions.view.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  String selectedTimePeriod = 'Today';
  //
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      handleGetProfile();
    });
    super.initState();
  }

  //handle load data
  void _loadData() async {
    var controller = Get.find<TransactionController>();
    await Future.wait([
      controller.getRecentTransactions(period: selectedTimePeriod),
      controller.getTransactionSummaryByPeriod(selectedTimePeriod),
      controller.getTransactionChartData(selectedTimePeriod)
    ]);
  }

  //handle get profile
  void handleGetProfile() async {
    var authController = Get.find<AuthController>();
    await authController.getProfile();
    //refresh authInfo
    var controller = Get.find<TransactionController>();
    controller.authResponse = authController.authResponse;
    controller.update();
  }

  void _selectTimePeriod(String period) async {
    setState(() {
      selectedTimePeriod = period;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthController(repository: Get.find<Repository>()),
        builder: (authController) {
          return GetBuilder(
              init: TransactionController(repository: Get.find()),
              builder: (controller) {
                return Stack(
                  children: [
                    AppView(
                        backgroundColor: Colors.white,
                        body: CustomScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              pinned: true,
                              backgroundColor: Colors.white,
                              automaticallyImplyLeading: false,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: Dimensions.getWidth(40),
                                      height: Dimensions.getWidth(40),
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.getBorderRadius(100)),
                                          image: controller.authResponse?.user
                                                      ?.picture !=
                                                  null
                                              ? DecorationImage(
                                                  image: NetworkImage(controller
                                                      .authResponse!
                                                      .user!
                                                      .picture!),
                                                  fit: BoxFit.cover)
                                              : null),
                                      child: controller.authResponse!.user!
                                                  .picture ==
                                              null
                                          ? Center(
                                              child: Text(
                                                  controller.authResponse!.user!
                                                      .firstName![0]
                                                      .toUpperCase(),
                                                  style: AppFontSize
                                                      .fontSizeMedium(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16)),
                                            )
                                          : null),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Income - Expense",
                                        style: AppFontSize.fontSizeMedium(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )),
                                  const SvgIcon(
                                    path: "assets/images/notification.svg",
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                            //sliver file remaining
                            SliverFillRemaining(
                              child: RefreshIndicator(
                                child: ListView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: [
                                    SizedBox(
                                      height: Dimensions.getHeight(10),
                                    ),
                                    //Subscription Notice Badge
                                    if (controller.authResponse != null) ...[
                                      SubscriptionNoticeBadge(
                                        subscription: controller
                                            .authResponse!.subscription,
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(10),
                                      ),
                                    ],

                                    // Income Expense Summary
                                    IncomeExpenseSummaryView(
                                      summary: controller.summary,
                                      currency: controller
                                              .authResponse?.user?.currency ??
                                          "",
                                    ),

                                    // Spend Frequency
                                    if (controller.chartData
                                        .where((item) => item.type.isNotEmpty)
                                        .toList()
                                        .isNotEmpty)
                                      SpendFrequencyChart(
                                        chartData: controller.chartData,
                                      ),
                                    // Time Period Selector
                                    Padding(
                                      padding: EdgeInsets.all(
                                          Dimensions.getPadding(15)),
                                      child: SizedBox(
                                        height: 50,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            ExpenseTrackerHelper
                                                .buildTimeButton(
                                                    'Today', selectedTimePeriod,
                                                    onPress: () {
                                              _selectTimePeriod("Today");
                                            }),
                                            ExpenseTrackerHelper
                                                .buildTimeButton(
                                                    'Week', selectedTimePeriod,
                                                    onPress: () {
                                              _selectTimePeriod("Week");
                                              controller.getRecentTransactions(
                                                  period: selectedTimePeriod);
                                            }),
                                            ExpenseTrackerHelper
                                                .buildTimeButton(
                                                    'Month', selectedTimePeriod,
                                                    onPress: () {
                                              _selectTimePeriod("Month");
                                            }),
                                            ExpenseTrackerHelper
                                                .buildTimeButton(
                                                    'Year', selectedTimePeriod,
                                                    onPress: () {
                                              _selectTimePeriod("Year");
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Recent Transactions
                                    RecentTransactionsView(
                                      transactions:
                                          controller.recentTransactions,
                                    ),
                                    SizedBox(
                                      height: Dimensions.getHeight(50),
                                    )
                                  ],
                                ),
                                onRefresh: () async {
                                  _loadData();
                                },
                              ),
                            )
                          ],
                        )),
                    if (controller.loading) const Loader()
                  ],
                );
              });
        });
  }
}
