import 'package:flutter/material.dart';
import 'package:ie_montrac/chart/financial.report.line.chart.dart';
import 'package:ie_montrac/chart/transaction.report.doughnut.chart.dart';
import 'package:ie_montrac/components/financial.report.chart.switch.card.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/transactions.category.summary.view.dart';

import '../../components/transaction.card.dart';
import '../../models/chart.segment.dart';
import '../../theme/app.colors.dart';

class FinancialReportScreen extends StatefulWidget {
  const FinancialReportScreen({Key? key}) : super(key: key);
  @override
  State<FinancialReportScreen> createState() => _FinancialReportScreenState();
}

class _FinancialReportScreenState extends State<FinancialReportScreen> {
  int chartIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: Dimensions.getIconSize(24),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        'Financial Report',
                        style: AppFontSize.fontSizeTitle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                        width:
                            Dimensions.getWidth(48)), // Balance the back button
                  ],
                ),

                // Month Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: Dimensions.getMargin(15)),
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getPadding(16),
                        vertical: Dimensions.getPadding(8),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: Dimensions.getIconSize(24),
                          ),
                          Text(
                            'Month',
                            style: AppFontSize.fontSizeMedium(),
                          ),
                        ],
                      ),
                    ),

                    //financial report chart switch section
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
                    '\$ 332',
                    style: AppFontSize.fontSizeMedium(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Graph
                Visibility(
                    visible: chartIndex == 0,
                    child: FinancialReportLineChart()),
                Visibility(
                    visible: chartIndex == 1,
                    child: Center(
                      child: TransactionReportDoughnutChart(
                        totalAmount: 332,
                        segments: ChartSegment.getChartSegment(),
                      ),
                    )),
                // Expense/Income Toggle
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: Dimensions.getMargin(16)),
                  padding: EdgeInsets.all(Dimensions.getPadding(4)),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius:
                        BorderRadius.circular(Dimensions.getBorderRadius(25)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.getPadding(12)),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            'Expense',
                            textAlign: TextAlign.center,
                            style:
                                AppFontSize.fontSizeMedium(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.getPadding(12)),
                          child: Text(
                            'Income',
                            textAlign: TextAlign.center,
                            style: AppFontSize.fontSizeMedium(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Transaction Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getPadding(15),
                        vertical: Dimensions.getPadding(8),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                            Dimensions.getBorderRadius(15)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: Dimensions.getIconSize(24),
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: Dimensions.getWidth(8)),
                          Text(
                            'Transaction',
                            style: AppFontSize.fontSizeMedium(),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.filter_list,
                      size: Dimensions.getIconSize(28),
                    ),
                  ],
                ),

                // Transactions List
                Visibility(
                  visible: false,
                  child: ListView.builder(
                    itemCount: 0,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, index) {
                      var item = null;
                      return TransactionCard(item: item);
                    },
                  ),
                ),
                SizedBox(
                  height: Dimensions.getHeight(20),
                ),
                //Transaction category summary view
                const TransactionsCategorySummaryView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
