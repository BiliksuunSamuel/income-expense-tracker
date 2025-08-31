import 'package:flutter/material.dart';

class BillingPlanItem extends StatelessWidget {
  final String feature;
  final bool isAvailable;
  final Color primaryColor;

  const BillingPlanItem({
    super.key,
    required this.feature,
    required this.isAvailable,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isAvailable ? Icons.check : Icons.close,
            color: isAvailable ? primaryColor : Colors.grey[400],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            feature,
            style: TextStyle(
              color: isAvailable ? Colors.black : Colors.grey[500],
              fontSize: 14,
            ),
          )),
        ],
      ),
    );
  }
}
