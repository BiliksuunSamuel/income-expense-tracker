import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/reports.controller.dart';
import 'package:ie_montrac/bottom-sheet/financial.report.filter.bottom.sheet.dart';
import 'package:ie_montrac/chart/financial.report.line.chart.dart';
import 'package:ie_montrac/chart/transaction.report.doughnut.chart.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/financial.report.chart.switch.card.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/utils/utilities.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../components/income.expense.report.card.dart';
import '../../models/chart.segment.dart';
import '../../theme/app.colors.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({Key? key}) : super(key: key);
  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  int chartIndex = 0;
  int selectedIndex = 0;

  //init
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  //load data
  void _loadData() async {
    var controller = Get.find<ReportsController>();
    await Future.wait([controller.getReports(from: null, to: null)]);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ReportsController(repository: Get.find()),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: AppView(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          title: AppHeaderTitle(
                            title: 'Financial Report',
                            rightComponent: InkWell(
                              child: Icon(
                                Icons.filter_list_outlined,
                                size: Dimensions.getIconSize(32),
                                color: Colors.black,
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext btx) {
                                      return FinancialReportFilterBottomSheet(
                                        onApplyFilter: (DateTime? from,
                                            DateTime? to) async {
                                          Navigator.pop(btx);
                                          await controller.getReports(
                                              from: from, to: to);
                                        },
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                        SliverFillRemaining(
                          child: ContentContainer(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                // Month Dropdown
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Spacer(), //financial report chart switch section
                                    FinancialReportChartSwitchCard(
                                        onPress: (int switchIndex) {
                                          setState(() {
                                            chartIndex = switchIndex;
                                          });
                                        },
                                        currentIndex: chartIndex)
                                  ],
                                ),

                                // Amount
                                Visibility(
                                  visible: chartIndex == 0,
                                  child: Text(
                                    selectedIndex == 0
                                        ? '${controller.authResponse?.user?.currency} ${controller.reports.totalExpense.toStringAsFixed(2)}'
                                        : '${controller.authResponse?.user?.currency} ${controller.reports.totalIncome.toStringAsFixed(2)}',
                                    style: AppFontSize.fontSizeMedium(
                                      fontSize: Dimensions.getFontSize(26),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: Dimensions.getHeight(15),
                                ),
                                // Graph
                                Visibility(
                                    visible: chartIndex == 0 &&
                                        (controller.reports.incomeReport
                                                .isNotEmpty ||
                                            controller.reports.expenseReport
                                                .isNotEmpty),
                                    child: FinancialReportLineChart(
                                      data: selectedIndex == 0
                                          ? controller.reports.expenseReport
                                          : controller.reports.incomeReport,
                                    )),
                                Visibility(
                                    visible: chartIndex == 1 &&
                                        (controller.reports.incomeReport
                                                .isNotEmpty ||
                                            controller.reports.expenseReport
                                                .isNotEmpty),
                                    child: Center(
                                      child: TransactionReportDoughnutChart(
                                        totalAmount: selectedIndex == 0
                                            ? controller.reports.totalExpense
                                            : controller.reports.totalIncome,
                                        segments: (selectedIndex == 0
                                                ? controller
                                                    .reports.expenseReport
                                                : controller
                                                    .reports.incomeReport)
                                            .map((e) => ChartSegment(
                                                value: e.value.abs(),
                                                color: mapCategoryToColor(
                                                    e.label)))
                                            .toList(),
                                        currency: controller
                                                .authResponse?.user?.currency ??
                                            "",
                                      ),
                                    )),
                                // Expense/Income Toggle
                                SizedBox(
                                  height: Dimensions.getHeight(15),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Dimensions.getMargin(16)),
                                  padding:
                                      EdgeInsets.all(Dimensions.getPadding(4)),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.getBorderRadius(25)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 0;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.getPadding(12)),
                                            decoration: selectedIndex == 0
                                                ? BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  )
                                                : null,
                                            child: Text(
                                              'Expense',
                                              textAlign: TextAlign.center,
                                              style: AppFontSize.fontSizeMedium(
                                                  color: selectedIndex == 0
                                                      ? Colors.white
                                                      : null),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = 1;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    Dimensions.getPadding(12)),
                                            decoration: selectedIndex == 1
                                                ? BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  )
                                                : null,
                                            child: Text(
                                              'Income',
                                              textAlign: TextAlign.center,
                                              style: AppFontSize.fontSizeMedium(
                                                  color: selectedIndex == 1
                                                      ? Colors.white
                                                      : null),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Transaction Header
                                Text(
                                  "Summary",
                                  style: AppFontSize.fontSizeMedium(
                                      fontSize: Dimensions.getFontSize(24)),
                                ),
                                const Divider(),

                                SizedBox(
                                  height: Dimensions.getHeight(10),
                                ),
                                //Transaction category summary view
                                SizedBox(
                                  height: Dimensions.getHeight(300),
                                  child: (selectedIndex == 0 &&
                                          controller
                                              .reports.expenseReport.isEmpty)
                                      ? Center(
                                          child: EmptyStateView(
                                            message: "No data available",
                                          ),
                                        )
                                      : (selectedIndex == 1 &&
                                              controller
                                                  .reports.incomeReport.isEmpty)
                                          ? Center(
                                              child: EmptyStateView(
                                                message: "No data available",
                                              ),
                                            )
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              itemCount: selectedIndex == 0
                                                  ? controller.reports
                                                      .expenseReport.length
                                                  : controller.reports
                                                      .incomeReport.length,
                                              itemBuilder:
                                                  (BuildContext btx, index) {
                                                var item = selectedIndex == 0
                                                    ? controller.reports
                                                        .expenseReport[index]
                                                    : controller.reports
                                                        .incomeReport[index];
                                                return IncomeExpenseReportCard(
                                                    report: item,
                                                    isIncome:
                                                        selectedIndex == 1,
                                                    totalValue: controller
                                                        .reports.totalExpense,
                                                    currency: controller
                                                            .authResponse
                                                            ?.user
                                                            ?.currency ??
                                                        "");
                                              }),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: controller.loading,
                      child: const Loader(),
                    )
                  ],
                )),
          );
        });
  }
}
