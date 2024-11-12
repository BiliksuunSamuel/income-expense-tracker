import 'package:flutter/material.dart';

import '../components/svg.icon.dart';
import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class IncomeExpenseSummaryView extends StatelessWidget {
  const IncomeExpenseSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getPadding(15)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(Dimensions.getBorderRadius(15)),
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.getBorderRadius(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.getBorderRadius(10)),
                    ),
                    child: const SvgIcon(
                      path: "assets/images/income.svg",
                      color: AppColors.greenColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.getWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Income',
                        style: AppFontSize.fontSizeMedium(color: Colors.white),
                      ),
                      Text(
                        '\$5000',
                        style: AppFontSize.fontSizeMedium(
                          fontSize: Dimensions.getFontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.getWidth(20),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(Dimensions.getBorderRadius(15)),
              decoration: BoxDecoration(
                color: AppColors.redColor,
                borderRadius:
                    BorderRadius.circular(Dimensions.getBorderRadius(20)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.getPadding(8)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.getBorderRadius(10)),
                    ),
                    child: const SvgIcon(
                      path: "assets/images/expense.svg",
                      color: AppColors.redColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.getWidth(10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expenses',
                        style: AppFontSize.fontSizeMedium(color: Colors.white),
                      ),
                      Text(
                        '\$1200',
                        style: AppFontSize.fontSizeMedium(
                          fontSize: Dimensions.getFontSize(20),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
