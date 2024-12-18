import 'package:flutter/material.dart';
import 'package:ie_montrac/components/bottom.sheet.container.dart';
import 'package:ie_montrac/components/custom.datetime.picker.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class FinancialReportFilterBottomSheet extends StatelessWidget {
  final Function(DateTime? from, DateTime? to) onApplyFilter;
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  FinancialReportFilterBottomSheet({super.key, required this.onApplyFilter});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(children: [
      const Center(
        child: Text(
          "Choose Filter",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      //create datetime picker input here
      CustomDateTimePicker(
        controller: fromController,
        label: "From Date",
        hintText: "Select From Date",
      ),
      //
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      CustomDateTimePicker(
        controller: toController,
        label: "To Date",
        hintText: "Select To Date",
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      ),
      PrimaryButton(
        title: "Apply Filter",
        onPressed: () {
          onApplyFilter(DateTime.parse(fromController.text),
              DateTime.parse(toController.text));
        },
      ),
      SizedBox(
        height: Dimensions.getHeight(20),
      )
    ]);
  }
}
