import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';

import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class TransactionSummaryCard extends StatelessWidget {
  final Color color;
  final String title;
  final String amount;
  final String iconPath;
  const TransactionSummaryCard(
      {super.key,
      required this.color,
      required this.title,
      required this.amount,
      required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.getBorderRadius(15)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(20)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(Dimensions.getBorderRadius(5)),
            ),
            child: SvgIcon(
              path: iconPath,
              color: color,
              width: Dimensions.getFontSize(20),
              height: Dimensions.getIconSize(20),
            ),
          ),
          SizedBox(width: Dimensions.getWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontSize.fontSizeMedium(
                      color: Colors.white,
                      fontSize: Dimensions.getFontSize(16)),
                ),
                Text(
                  amount,
                  style: AppFontSize.fontSizeMedium(
                    fontSize: Dimensions.getFontSize(16),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
