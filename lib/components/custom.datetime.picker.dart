import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/dimensions.dart';

class CustomDateTimePicker extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final Function(DateTime? dt)? handleChange;
  const CustomDateTimePicker(
      {super.key,
      this.label,
      this.hintText,
      this.handleChange,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return DateTimeField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(15)),
          borderSide:
              BorderSide(width: Dimensions.getWidth(0.35), color: Colors.grey),
        ),
      ),
      format: DateFormat("yyyy-MM-dd"),
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (handleChange != null) {
          handleChange!(date);
        }
        return date;
      },
    );
  }
}
