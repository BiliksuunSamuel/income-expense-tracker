import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/enums/transaction.category.dart';
import 'package:ie_montrac/models/Transaction.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class TransactionCard extends StatelessWidget {
  final Transaction item;
  const TransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.getHeight(80),
      padding: EdgeInsets.all(Dimensions.getPadding(8)),
      margin: EdgeInsets.symmetric(vertical: Dimensions.getHeight(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(5)),
        color: Colors.grey.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.getPadding(15)),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.getBorderRadius(15)),
                color: item.color.withOpacity(0.18)),
            child: SvgIcon(
              path: item.iconPath,
              color: item.color,
              width: Dimensions.getIconSize(28),
              height: Dimensions.getIconSize(28),
            ),
          ),
          SizedBox(
            width: Dimensions.getWidth(10),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: AppFontSize.fontSizeTitle(fontWeight: FontWeight.normal),
              ),
              Text(
                item.description,
                style: AppFontSize.fontSizeMedium(
                    fontSize: Dimensions.getFontSize(14),
                    color: Colors.black.withOpacity(0.5)),
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                item.amount,
                style: AppFontSize.fontSizeMedium(
                    color: item.category == TransactionCategory.Expense
                        ? AppColors.redColor
                        : AppColors.greenColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                item.time,
                style: AppFontSize.fontSizeMedium(
                    fontSize: Dimensions.getFontSize(14),
                    color: Colors.black.withOpacity(0.5)),
              )
            ],
          )
        ],
      ),
    );
  }
}
