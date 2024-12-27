import 'package:flutter/material.dart';
import 'package:ie_montrac/components/custom.datetime.picker.dart';
import 'package:ie_montrac/components/custom.dropdown.dart';
import 'package:ie_montrac/utils/utilities.dart';

import '../components/bottom.sheet.container.dart';
import '../components/primary.button.dart';
import '../constants/app.options.dart';
import '../models/category.dart';
import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class TransactionHistoryFilterBottomSheet extends StatelessWidget {
  final Function(String type) onTransactionTypeChanged;
  final String transactionType;
  final Function() onApply;
  final List<Category> categories;
  final Category? selectedCategory;
  final TextEditingController? startDateController;
  final TextEditingController? endDateController;
  final Function(Category? category)? onCategoryChanged;
  final Function() resetFilter;
  const TransactionHistoryFilterBottomSheet(
      {super.key,
      required this.transactionType,
      required this.onTransactionTypeChanged,
      required this.onApply,
      required this.categories,
      this.selectedCategory,
      this.onCategoryChanged,
      this.startDateController,
      this.endDateController,
      required this.resetFilter});

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
              resetFilter();
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Transaction Type",
            style: AppFontSize.fontSizeMedium(),
            textAlign: TextAlign.left,
          ),
        ],
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Category",
            style: AppFontSize.fontSizeMedium(),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(15),
      ),
      CustomDropdown(
          items: categories,
          selectedValue: selectedCategory,
          hintText: "Select Category",
          label: "Transaction Category",
          onChanged: (Category? category) {
            if (onCategoryChanged != null) {
              onCategoryChanged!(category);
            }
          },
          itemLabel: (Category item) {
            return item.title;
          }),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Date Range",
            style: AppFontSize.fontSizeMedium(),
            textAlign: TextAlign.left,
          ),
        ],
      ),
      SizedBox(
        height: Dimensions.getHeight(15),
      ),
      CustomDateTimePicker(
        label: "Start Date",
        controller: startDateController,
        hintText: "Start Date",
      ),
      SizedBox(
        height: Dimensions.getHeight(15),
      ),
      CustomDateTimePicker(
        label: "End Date",
        controller: endDateController,
        hintText: "End Date",
      ),
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
