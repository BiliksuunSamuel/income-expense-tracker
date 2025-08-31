import 'package:flutter/material.dart';
import 'package:ie_montrac/components/transaction.summary.card.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/models/transaction.summary.dart';

import '../theme/app.colors.dart';
import '../utils/dimensions.dart';

class IncomeExpenseSummaryView extends StatelessWidget {
  final TransactionSummary summary;
  final String currency;
  const IncomeExpenseSummaryView(
      {super.key, required this.summary, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getPadding(15)),
      child: Row(
        children: [
          Expanded(
            child: TransactionSummaryCard(
                color: AppColors.greenColor,
                title: "Income",
                amount: "${currency} ${summary.income}",
                iconPath: Resources.income),
          ),
          SizedBox(
            width: Dimensions.getWidth(15),
          ),
          Expanded(
              child: TransactionSummaryCard(
                  color: AppColors.redColor,
                  title: "Expense",
                  amount: "GHS ${summary.expense}",
                  iconPath: Resources.expense)),
        ],
      ),
    );
  }
}
