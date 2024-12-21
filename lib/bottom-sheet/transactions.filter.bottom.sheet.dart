import 'package:flutter/material.dart';
import 'package:ie_montrac/components/bottom.sheet.container.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/constants/app.options.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/utils/utilities.dart';

class TransactionsFilterBottomSheet extends StatelessWidget {
  final Function(String type) onTransactionTypeChanged;
  final String transactionType;
  final Function()? onApply;
  const TransactionsFilterBottomSheet(
      {super.key,
      required this.transactionType,
      required this.onTransactionTypeChanged,
      this.onApply});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Filter Transactions",
            style: AppFontSize.fontSizeTitle(),
          ),
          InkWell(
            onTap: () {
              onTransactionTypeChanged("All");
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getPadding(15),
                  vertical: Dimensions.getHeight(5)),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(20)),
                  color: AppColors.primaryColor.withOpacity(0.15)),
              child: Center(
                child: Text(
                  "Reset",
                  style: AppFontSize.fontSizeMedium(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      Text(
        "Transaction Type",
        style: AppFontSize.fontSizeMedium(),
        textAlign: TextAlign.left,
      ),
      SizedBox(
        height: Dimensions.getHeight(15),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: AppOptions.transactionTypes.map((item) {
          return Expanded(
              child: InkWell(
            onTap: () {
              onTransactionTypeChanged(item);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.getPadding(15),
                  vertical: Dimensions.getHeight(8)),
              margin: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(5)),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.getBorderRadius(30)),
                  color: item.equals(transactionType)
                      ? AppColors.primaryColor.withOpacity(0.15)
                      : Colors.transparent,
                  border: Border.all(width: Dimensions.getWidth(0.15))),
              child: Text(
                item,
                style: AppFontSize.fontSizeMedium(
                  fontSize: Dimensions.getFontSize(16),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ));
        }).toList(),
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      // Text(
      //   "Sort By",
      //   style: AppFontSize.fontSizeMedium(),
      // ),
      // SizedBox(
      //   height: Dimensions.getHeight(20),
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: ["Highest", "Lowest", "Newest", "Oldest"].map((item) {
      //     return Expanded(
      //         child: InkWell(
      //       child: Container(
      //         padding: EdgeInsets.symmetric(
      //             horizontal: Dimensions.getPadding(10),
      //             vertical: Dimensions.getHeight(8)),
      //         margin: EdgeInsets.symmetric(horizontal: Dimensions.getWidth(5)),
      //         decoration: BoxDecoration(
      //             borderRadius:
      //                 BorderRadius.circular(Dimensions.getBorderRadius(30)),
      //             border: Border.all(width: Dimensions.getWidth(0.15))),
      //         child: Text(
      //           item,
      //           style: AppFontSize.fontSizeSmall(),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ));
      //   }).toList(),
      // ),
      // SizedBox(
      //   height: Dimensions.getHeight(20),
      // ),
      // Text(
      //   "Category",
      //   style: AppFontSize.fontSizeMedium(),
      // ),
      // SizedBox(
      //   height: Dimensions.getHeight(20),
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text(
      //       "Choose Category",
      //       style: AppFontSize.fontSizeMedium(fontWeight: FontWeight.w300),
      //     ),
      //     Row(
      //       children: [
      //         Text(
      //           "0",
      //           style: AppFontSize.fontSizeSmall(),
      //         ),
      //         SizedBox(
      //           width: Dimensions.getWidth(5),
      //         ),
      //         Text(
      //           "Selected",
      //           style: AppFontSize.fontSizeSmall(fontWeight: FontWeight.w300),
      //         ),
      //         SizedBox(
      //           width: Dimensions.getWidth(5),
      //         ),
      //         Icon(
      //           Icons.chevron_right_outlined,
      //           color: AppColors.primaryColor,
      //           size: Dimensions.getIconSize(24),
      //         )
      //       ],
      //     ),
      //   ],
      // ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      PrimaryButton(
        title: "Apply",
        onPressed: onApply,
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
    ]);
  }
}
