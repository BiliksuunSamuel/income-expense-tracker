import 'package:flutter/material.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/models/transaction.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';
import '../utils/utilities.dart';

class TransactionItemCard extends StatelessWidget {
  final Function()? onPress;
  final Transaction transaction;
  TransactionItemCard({super.key, required this.transaction, this.onPress});

  @override
  Widget build(BuildContext context) {
    var icon = mapCategoryToIcon(transaction.category);
    var color =
        mapCategoryToColor(transaction.category).withValues(alpha: 0.25);
    var iconColor = mapCategoryToColor(transaction.category);
    var title = transaction.category.toTitleCase();
    var subtitle = transaction.description;
    var amount =
        "${transaction.currency} ${transaction.amount.toStringAsFixed(2)}";
    var time = transaction.createdAt.toTimeOfDay;
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(bottom: Dimensions.getPadding(20)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgIcon(
                path: icon,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFontSize.fontSizeMedium(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.getFontSize(16),
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: AppFontSize.fontSizeMedium(
                        color: Colors.grey[600],
                        fontSize: Dimensions.getFontSize(14),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      transaction.type == "Income"
                          ? Icons.arrow_downward_outlined
                          : Icons.arrow_upward_outlined,
                      size: Dimensions.getWidth(12),
                      color: transaction.type == "Income"
                          ? AppColors.greenColor
                          : AppColors.redColor,
                    ),
                    SizedBox(
                      width: Dimensions.getWidth(5),
                    ),
                    Text(
                      amount,
                      style: AppFontSize.fontSizeMedium(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.getFontSize(16),
                        color: transaction.type == "Income"
                            ? AppColors.greenColor
                            : AppColors.redColor,
                      ),
                    )
                  ],
                ),
                Text(
                  time ?? "",
                  style: AppFontSize.fontSizeMedium(
                    color: Colors.grey[600],
                    fontSize: Dimensions.getFontSize(14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
