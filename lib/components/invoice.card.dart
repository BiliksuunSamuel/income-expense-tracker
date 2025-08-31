import 'package:flutter/material.dart';
import 'package:ie_montrac/constants/payment.status.dart';
import 'package:ie_montrac/models/invoice.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/utils/utilities.dart';
import 'package:intl/intl.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  final String currency;
  final VoidCallback? onTap;

  const InvoiceCard({
    Key? key,
    required this.invoice,
    required this.currency,
    this.onTap,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case PaymentStatus.completed:
        return Colors.green.shade100;
      case PaymentStatus.pending:
        return Colors.orange.shade100;
      case PaymentStatus.failed:
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(symbol: currency).format(amount);
  }

  bool _isOverdue() {
    return invoice.status != PaymentStatus.completed &&
        DateTime.now().isAfter(invoice.dueDate!);
  }

  @override
  Widget build(BuildContext context) {
    final isOverdue = _isOverdue();

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              width: Dimensions.getWidth(0.25), color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(20))),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          invoice.invoiceNumber ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                invoice.description!.isNotEmpty
                                    ? invoice.description!
                                    : 'Subscription ${invoice.subscriptionId.substring(0, 8)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Amount Row
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    _formatCurrency(invoice.amount),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Status and Dates Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Status badges
                  Wrap(
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.getPadding(10),
                          vertical: Dimensions.getPadding(4),
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(invoice.status),
                          borderRadius: BorderRadius.circular(
                              Dimensions.getBorderRadius(12)),
                          border: Border.all(
                            color: getPaymentStatusColor(invoice.status)
                                .withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          invoice.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: Dimensions.getFontSize(11),
                            fontWeight: FontWeight.w600,
                            color: getPaymentStatusColor(invoice.status),
                          ),
                        ),
                      ),
                      if (isOverdue)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.getPadding(10),
                            vertical: Dimensions.getPadding(4),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.red.shade200,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'OVERDUE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Dates column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: Dimensions.getIconSize(14),
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(width: Dimensions.getWidth(4)),
                          Text(
                            'Due ${formatDate(invoice.dueDate!)}',
                            style: TextStyle(
                              fontSize: Dimensions.getFontSize(12),
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.getHeight(4)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: Dimensions.getIconSize(14),
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(width: Dimensions.getWidth(4)),
                          Text(
                            'Created ${formatDate(invoice.createdAt)}',
                            style: TextStyle(
                              fontSize: Dimensions.getFontSize(12),
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
