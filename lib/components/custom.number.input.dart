import 'package:flutter/material.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class CustomNumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? prefix;
  const CustomNumberInput({super.key, this.controller, this.prefix = " GHS"});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      controller: controller,
      cursorHeight: Dimensions.getHeight(25),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Padding(
            padding: EdgeInsets.only(
                left: Dimensions.getPadding(8), top: Dimensions.getHeight(6)),
            child: Text(
              "$prefix ",
              style: AppFontSize.fontSizeTitle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.getFontSize(32),
                  color: Colors.white),
            ),
          ),
          hintText: "0.00",
          hintStyle: AppFontSize.fontSizeTitle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.getFontSize(36),
              color: Colors.white),
          border: const OutlineInputBorder(borderSide: BorderSide.none)),
      style: AppFontSize.fontSizeTitle(
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.getFontSize(36),
          color: Colors.white),
      inputFormatters: [
        NumberTextInputFormatter(
          integerDigits: 6,
          decimalDigits: 2,
          maxValue: '1000000000.00',
          decimalSeparator: '.',
          groupDigits: 3,
          groupSeparator: ',',
          allowNegative: false,
          overrideDecimalPoint: true,
          insertDecimalPoint: false,
          insertDecimalDigits: true,
        ),
      ],
      keyboardType: TextInputType.number,
    );
  }
}
