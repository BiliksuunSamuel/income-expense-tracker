import 'package:flutter/material.dart';
import 'package:ie_montrac/chart/spend.frequency.chart.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/expense.tracker.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/income.expense.summary.view.dart';
import 'package:ie_montrac/views/recent.transactions.view.dart';

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
    super.initState();
  }
  //

  void _selectTimePeriod(String period) {
    setState(() {
      selectedTimePeriod = period;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(Dimensions.getPadding(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: Dimensions.getWidth(40),
                          height: Dimensions.getWidth(40),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.getBorderRadius(100))),
                        ),
                        const Spacer(),
                        Expanded(
                            child: Row(
                          children: [
                            const Icon(Icons.keyboard_arrow_down,
                                color: AppColors.primaryColor),
                            Text(
                              'October',
                              style: AppFontSize.fontSizeMedium(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )),
                        const Spacer(),
                        const SvgIcon(
                          path: "assets/images/notification.svg",
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  // Balance
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.getPadding(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Account Balance',
                            style: AppFontSize.fontSizeMedium(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '\$9400',
                            style: AppFontSize.fontSizeTitle(
                              fontSize: Dimensions.getFontSize(32),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const IncomeExpenseSummaryView(),

                  // Spend Frequency
                  const SpendFrequencyChart(),
                  // Time Period Selector
                  Padding(
                    padding: EdgeInsets.all(Dimensions.getPadding(15)),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ExpenseTrackerHelper.buildTimeButton(
                              'Today', selectedTimePeriod, onPress: () {
                            _selectTimePeriod("Today");
                          }),
                          ExpenseTrackerHelper.buildTimeButton(
                              'Week', selectedTimePeriod, onPress: () {
                            _selectTimePeriod("Week");
                          }),
                          ExpenseTrackerHelper.buildTimeButton(
                              'Month', selectedTimePeriod, onPress: () {
                            _selectTimePeriod("Month");
                          }),
                          ExpenseTrackerHelper.buildTimeButton(
                              'Year', selectedTimePeriod, onPress: () {
                            _selectTimePeriod("Year");
                          }),
                        ],
                      ),
                    ),
                  ),

                  // Recent Transactions
                  const RecentTransactionsView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
