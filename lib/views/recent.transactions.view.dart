import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/transaction.item.card.dart';
import 'package:ie_montrac/models/transaction.dart';
import 'package:ie_montrac/screens/home/transaction.details.screen.dart';
import 'package:ie_montrac/screens/home/transaction.history.screen.dart';

import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class RecentTransactionsView extends StatelessWidget {
  final List<Transaction> transactions;
  const RecentTransactionsView({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.getPadding(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Transaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const TransactionHistoryScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.getPadding(5),
                      horizontal: Dimensions.getPadding(15)),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(
                          Dimensions.getBorderRadius(20))),
                  child: Text(
                    'See All',
                    style: AppFontSize.fontSizeMedium(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.getFontSize(14)),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          if (transactions.isEmpty)
            Center(
              child: EmptyStateView(),
            )
          else
            ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (BuildContext ctx, index) {
                  var item = transactions[index];
                  return TransactionItemCard(
                    onPress: () {
                      Get.to(() => const TransactionDetailsScreen(),
                          arguments: {
                            "transactionId": item.id,
                            "transactionType": item.type
                          });
                    },
                    transaction: item,
                  );
                })
        ],
      ),
    );
  }
}
