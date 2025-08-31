import 'package:flutter/material.dart';
import 'package:ie_montrac/constants/payment.status.dart';

import '../models/invoice.dart';
import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';
import '../utils/utilities.dart';

class InvoicePaymentInformationSection extends StatelessWidget {
  final Invoice invoice;
  const InvoicePaymentInformationSection({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(10)),
          border: Border.all(
              width: Dimensions.getWidth(0.25), color: Colors.grey.shade400)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.getPadding(10)),
            decoration: BoxDecoration(
                color: Colors.grey.shade100.withValues(alpha: 0.45),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.getBorderRadius(10)),
                    topLeft: Radius.circular(Dimensions.getBorderRadius(10))),
                //Bottom border
                border: Border(
                    bottom: BorderSide(
                        width: Dimensions.getWidth(0.15),
                        color: Colors.grey.shade400))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "Payment Information",
                  style: AppFontSize.fontSizeMedium(),
                )),
                if (invoice.dueDate!.isBefore(DateTime.now()) &&
                    invoice.amount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.getPadding(10),
                        vertical: Dimensions.getPadding(2.5)),
                    decoration: BoxDecoration(
                        color: (invoice.status == PaymentStatus.completed
                                ? AppColors.primaryColor
                                : invoice.status == PaymentStatus.refunded
                                    ? AppColors.textGray
                                    : AppColors.redColor)
                            .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                            Dimensions.getBorderRadius(20))),
                    child: Text(
                      invoice.status == PaymentStatus.completed
                          ? "Paid"
                          : invoice.status == PaymentStatus.refunded
                              ? "Refunded"
                              : "OVERDUE",
                      style: AppFontSize.fontSizeSmall(
                          color: invoice.status == PaymentStatus.completed
                              ? AppColors.primaryDark
                              : invoice.status == PaymentStatus.refunded
                                  ? AppColors.textGray
                                  : AppColors.redColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.getFontSize(12)),
                    ),
                  )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.getHeight(2),
          ),
          ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: Dimensions.getPadding(10)),
            title: Text(
              "Due Date",
              style: AppFontSize.fontSizeSmall(color: Colors.grey.shade600),
            ),
            trailing: Text(
              formatDate(invoice!.dueDate!),
              style: AppFontSize.fontSizeSmall(fontWeight: FontWeight.w400),
            ),
          ),
          Divider(
            height: Dimensions.getHeight(0.15),
            color: Colors.grey.shade100,
          ),
          ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: Dimensions.getPadding(10)),
            title: Text(
              "Payment Status",
              style: AppFontSize.fontSizeSmall(color: Colors.grey.shade600),
            ),
            trailing: Text(
              invoice.status,
              style: AppFontSize.fontSizeSmall(
                  fontWeight: FontWeight.bold,
                  color: getPaymentStatusColor(invoice.status)),
            ),
          ),
          Divider(
            height: Dimensions.getHeight(0.15),
            color: Colors.grey.shade100,
          ),
          ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: Dimensions.getPadding(10)),
            title: Text(
              "Start Date",
              style: AppFontSize.fontSizeSmall(color: Colors.grey.shade600),
            ),
            trailing: Text(
              formatDate(invoice!.startDate!),
              style: AppFontSize.fontSizeSmall(fontWeight: FontWeight.w400),
            ),
          ),
          Divider(
            height: Dimensions.getHeight(0.15),
            color: Colors.grey.shade100,
          ),
          ListTile(
            dense: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: Dimensions.getPadding(10)),
            title: Text(
              "End Date",
              style: AppFontSize.fontSizeSmall(color: Colors.grey.shade600),
            ),
            trailing: Text(
              invoice?.endDate != null ? formatDate(invoice!.endDate!) : "N/A",
              style: AppFontSize.fontSizeSmall(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
