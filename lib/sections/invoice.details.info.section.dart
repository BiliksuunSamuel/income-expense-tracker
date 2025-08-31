import 'package:flutter/material.dart';
import 'package:ie_montrac/models/invoice.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class InvoiceDetailsInfoSection extends StatelessWidget {
  final Invoice invoice;
  final String currency;
  const InvoiceDetailsInfoSection(
      {super.key, required this.invoice, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.getPadding(14)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(10)),
          border: Border.all(
              width: Dimensions.getWidth(0.15), color: Colors.grey.shade400),
          color: Colors.grey.shade100.withValues(alpha: 0.45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  invoice.invoiceNumber ?? "N/A",
                  style:
                      AppFontSize.fontSizeMedium(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.getPadding(15),
                    vertical: Dimensions.getPadding(2.5)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.getBorderRadius(20)),
                    color: AppColors.primaryColor.withValues(alpha: 0.15)),
                child: Text("$currency${invoice.amount}",
                    style: AppFontSize.fontSizeMedium(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.getFontSize(14),
                        color: AppColors.primaryDark)),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.getHeight(5),
          ),
          Text(
            invoice.description ?? "",
            style: AppFontSize.fontSizeSmall(color: Colors.grey.shade600),
          )
        ],
      ),
    );
  }
}
