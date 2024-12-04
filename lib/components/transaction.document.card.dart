import 'package:flutter/material.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class TransactionDocument extends StatelessWidget {
  final String? fileName;
  const TransactionDocument({super.key, this.fileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.getPadding(8)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(10)),
          border: Border.all(
              width: Dimensions.getWidth(0.25), color: AppColors.textGray)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            fileName ?? 'No file selected.',
            style: AppFontSize.fontSizeMedium(color: AppColors.textGray),
            textAlign: TextAlign.center,
          ))
        ],
      ),
    );
  }
}
