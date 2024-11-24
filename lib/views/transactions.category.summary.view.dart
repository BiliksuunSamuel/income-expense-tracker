import 'package:flutter/material.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

class TransactionCategorySummary {
  final String category;
  final double amount;
  final Color color;
  final double percentage;

  TransactionCategorySummary({
    required this.category,
    required this.amount,
    required this.color,
    required this.percentage,
  });
}

List<TransactionCategorySummary> getData() {
  return [
    TransactionCategorySummary(
        category: "Shopping",
        amount: -120,
        color: Color(0xFFF4B754),
        percentage: 0.75),
    TransactionCategorySummary(
        category: "Subcription",
        amount: -80,
        color: Color(0xFF8B5CF6),
        percentage: 0.50),
    TransactionCategorySummary(
        category: "Food",
        amount: -32,
        color: Color(0xFFEF4444),
        percentage: 0.25),
  ];
}

class TransactionsCategorySummaryView extends StatelessWidget {
  const TransactionsCategorySummaryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getData()
          .map((transaction) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Dimensions.getHeight(40),
                          padding: EdgeInsets.all(Dimensions.getPadding(8)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.getBorderRadius(20)),
                              border: Border.all(
                                  width: Dimensions.getWidth(0.25),
                                  color: Colors.grey)),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.getWidth(15),
                                height: Dimensions.getWidth(15),
                                decoration: BoxDecoration(
                                  color: transaction.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: Dimensions.getHeight(10)),
                              Text(
                                transaction.category,
                                style: AppFontSize.fontSizeMedium(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '- \$${transaction.amount.abs().toStringAsFixed(0)}',
                          style: AppFontSize.fontSizeMedium(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.getHeight(10)),
                    SizedBox(
                      height: Dimensions.getHeight(13),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.getBorderRadius(10)),
                        child: LinearProgressIndicator(
                          value: transaction.percentage,
                          backgroundColor: Colors.grey[200],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(transaction.color),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
