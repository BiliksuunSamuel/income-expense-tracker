import 'package:flutter/material.dart';
import 'package:ie_montrac/components/bottom.sheet.container.dart';
import 'package:ie_montrac/components/custom.input.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class CreateBudgetCategoryBottomSheet extends StatelessWidget {
  final TextEditingController categoryTitleController;
  final TextEditingController categoryDescriptionController;
  final Function()? onSubmit;
  final bool loading;
  const CreateBudgetCategoryBottomSheet(
      {super.key,
      required this.categoryTitleController,
      required this.categoryDescriptionController,
      this.onSubmit,
      required this.loading});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(children: [
      Text(
        "Create Budget Category",
        style: AppFontSize.fontSizeMedium(),
      ),
      SizedBox(
        height: Dimensions.getHeight(10),
      ),
      CustomInput(
        hintText: "Category Name",
        controller: categoryTitleController,
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      CustomInput(
        hintText: "Category Description",
        minLines: 2,
        controller: categoryDescriptionController,
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      PrimaryButton(
        title: "Submit",
        onPressed: onSubmit,
        disabled: loading,
      ),
      SizedBox(
        height: Dimensions.getHeight(25),
      )
    ]);
  }
}
