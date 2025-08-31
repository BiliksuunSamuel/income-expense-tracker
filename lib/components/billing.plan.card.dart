import 'package:flutter/material.dart';
import 'package:ie_montrac/models/billing.plan.dart';
import 'package:ie_montrac/utils/dimensions.dart';

import 'billing.plan.item.dart';

class BillingPlanCard extends StatelessWidget {
  final BillingPlan billingPlan;
  final Color primaryColor;
  final VoidCallback? onTap;
  final String? priceSubtext;
  final String price;
  final bool isCurrentPlan;
  final String buttonText;
  final BillingPlan? selectedBillingPlan;

  const BillingPlanCard({
    super.key,
    required this.billingPlan,
    required this.primaryColor,
    required this.price,
    required this.buttonText,
    this.priceSubtext,
    this.isCurrentPlan = false,
    this.onTap,
    this.selectedBillingPlan,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(16)),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(Dimensions.getPadding(20)),
        margin: EdgeInsets.only(bottom: Dimensions.getHeight(15)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.getBorderRadius(16)),
          border: Border.all(
              color: selectedBillingPlan?.id == billingPlan.id
                  ? primaryColor
                  : Colors.grey[200]!,
              width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Price Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        billingPlan.title,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                // Price section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            color: billingPlan.isFree
                                ? Colors.green[600]
                                : primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1,
                          ),
                        ),
                        if (priceSubtext != null) ...[
                          const SizedBox(width: 2),
                          Text(
                            priceSubtext!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (billingPlan.isFree)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Free Forever',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Description (main body)
            Text(
              billingPlan.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 24),

            // Features list
            Column(
              children: [
                ...billingPlan.features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: BillingPlanItem(
                      feature: feature,
                      isAvailable: true,
                      primaryColor: primaryColor,
                    ),
                  ),
                ),
                if (billingPlan.maxNumberOfTransactions != -1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: BillingPlanItem(
                      feature:
                          "Up to ${billingPlan.maxNumberOfTransactions} transactions",
                      isAvailable: true,
                      primaryColor: primaryColor,
                    ),
                  ),
                if (billingPlan.maxNumberOfTransactions == -1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: BillingPlanItem(
                      feature: "Unlimited transactions",
                      isAvailable: true,
                      primaryColor: primaryColor,
                    ),
                  ),
                if (billingPlan.unavailableFeatures.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Divider(color: Colors.grey[200], thickness: 1),
                  const SizedBox(height: 8),
                  ...billingPlan.unavailableFeatures.map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: BillingPlanItem(
                        feature: feature,
                        isAvailable: false,
                        primaryColor: primaryColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
