import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/screens/home/transaction.details.screen.dart';

import '../helper/expense.tracker.dart';
import '../theme/app.colors.dart';
import '../theme/app.font.size.dart';
import '../utils/dimensions.dart';

class RecentTransactionsView extends StatefulWidget {
  const RecentTransactionsView({super.key});

  @override
  State<RecentTransactionsView> createState() => _RecentTransactionsViewState();
}

class _RecentTransactionsViewState extends State<RecentTransactionsView> {
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

          // Transaction List
          ExpenseTrackerHelper.buildTransactionItem(
              icon: "assets/images/shopping.svg",
              color: AppColors.orangeColor.withOpacity(0.15),
              title: 'Shopping',
              subtitle: 'Buy some grocery',
              amount: '- \$120',
              time: '10:00 AM',
              iconColor: AppColors.orangeColor),
          const SizedBox(height: 16),
          ExpenseTrackerHelper.buildTransactionItem(
              onPress: () => {Get.to(() => const TransactionDetailsScreen())},
              icon: "assets/images/subscription.svg",
              color: AppColors.primaryColor.withOpacity(0.15),
              title: 'Subscription',
              subtitle: 'Disney+ Annual..',
              amount: '- \$80',
              time: '03:30 PM',
              iconColor: AppColors.primaryColor),
          const SizedBox(height: 16),
          ExpenseTrackerHelper.buildTransactionItem(
              icon: "assets/images/restaurant.svg",
              color: AppColors.redColor.withOpacity(0.15),
              title: 'Food',
              subtitle: 'Buy a ramen',
              amount: '- \$32',
              time: '07:30 PM',
              iconColor: AppColors.redColor),
        ],
      ),
    );
  }
}
