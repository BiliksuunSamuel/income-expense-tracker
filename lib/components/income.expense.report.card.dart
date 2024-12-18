import 'package:flutter/material.dart';
import 'package:ie_montrac/models/income.expense.report.dart';
import 'package:ie_montrac/utils/utilities.dart';

import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class IncomeExpenseReportCard extends StatelessWidget {
  final IncomeExpenseReport report;
  final String currency;
  final double totalValue;
  const IncomeExpenseReportCard(
      {super.key,
      required this.report,
      required this.currency,
      required this.totalValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.getHeight(20)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.getPadding(8)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.getBorderRadius(20)),
                    border: Border.all(
                        width: Dimensions.getWidth(0.25), color: Colors.grey)),
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.getWidth(15),
                        height: Dimensions.getWidth(15),
                        decoration: BoxDecoration(
                          color: mapCategoryToColor(report.label),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: Dimensions.getHeight(10)),
                      Text(
                        report.label.toTitleCase(),
                        style: AppFontSize.fontSizeMedium(
                          color: Colors.black87,
                          fontSize: Dimensions.getFontSize(15),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '$currency ${report.value.abs().toStringAsFixed(2)}',
                style: AppFontSize.fontSizeMedium(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.getHeight(10)),
          SizedBox(
            height: Dimensions.getHeight(13),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(Dimensions.getBorderRadius(10)),
              child: LinearProgressIndicator(
                value: report.value.abs() / totalValue,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                    mapCategoryToColor(report.label)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
