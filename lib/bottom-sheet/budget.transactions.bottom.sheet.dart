import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/bottom.sheet.container.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/transaction.item.card.dart';
import 'package:ie_montrac/models/transaction.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';

import '../screens/home/transaction.details.screen.dart';

class BudgetTransactionsBottomSheet extends StatelessWidget {
  final List<Transaction> transactions;
  const BudgetTransactionsBottomSheet({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
        height: Dimensions.deviceHeight * 0.8,
        children: [
          Text(
            "Budget Transactions",
            style: AppFontSize.fontSizeMedium(),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.15),
          ),
          SizedBox(
            height: Dimensions.getHeight(15),
          ),
          SizedBox(
            height: Dimensions.deviceHeight * 0.6, // Adjust height as needed
            child: transactions.isEmpty
                ? Center(
                    child: EmptyStateView(
                      message: "No transactions found!",
                    ),
                  )
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      var transaction = transactions[index];
                      return TransactionItemCard(
                        transaction: transaction,
                        onPress: () {
                          Navigator.pop(context);
                          Get.to(() => const TransactionDetailsScreen(),
                              arguments: {
                                "transactionId": transaction.id,
                                "transactionType": transaction.type
                              });
                        },
                      );
                    },
                  ),
          ),
        ]);
  }
}
