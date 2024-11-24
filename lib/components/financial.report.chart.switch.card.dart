import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/utils/dimensions.dart';

import '../helper/resources.dart';
import '../theme/app.colors.dart';

class FinancialReportChartSwitchCard extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onPress;
  const FinancialReportChartSwitchCard({super.key,required this.onPress,required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.getMargin(15)),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: Dimensions.getHeight(0.15),
              color: Colors.grey)),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              onPress(0);
            },
            child: Container(
              padding:
              EdgeInsets.all(Dimensions.getPadding(14)),
              decoration: BoxDecoration(
                  color: currentIndex == 0
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          Dimensions.getBorderRadius(10)),
                      bottomLeft: Radius.circular(
                          Dimensions.getBorderRadius(10)))),
              child: SvgIcon(
                path: Resources.lineChart,
                color: currentIndex == 0
                    ? Colors.white
                    : AppColors.primaryColor,
                height: Dimensions.getIconSize(22),
                width: Dimensions.getIconSize(22),
              ),
            ),
          ),
          InkWell(
            onTap: () {
             onPress(1);
            },
            child: Container(
              padding:
              EdgeInsets.all(Dimensions.getPadding(14)),
              decoration: BoxDecoration(
                  color: currentIndex == 1
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                          Dimensions.getBorderRadius(10)),
                      bottomRight: Radius.circular(
                          Dimensions.getBorderRadius(10)))),
              child: SvgIcon(
                path: Resources.piechart,
                color: currentIndex == 1
                    ? Colors.white
                    : AppColors.primaryColor,
                height: Dimensions.getIconSize(24),
                width: Dimensions.getIconSize(24),
              ),
            ),
          )
        ],
      ),
    );
  }
}
