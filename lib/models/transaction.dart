import 'package:flutter/material.dart';
import 'package:ie_montrac/enums/transaction.category.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';

class Transaction {
  final String title;
  final String description;
  final String time;
  final String amount;
  final Color color;
  final String iconPath;
  final TransactionCategory category;

  Transaction(
      {required this.title,
      required this.description,
      required this.time,
      required this.amount,
      required this.color,
      required this.iconPath,
      required this.category});

  static List<Transaction> getPastTransactions() {
    return [
      Transaction(
          title: "Salary",
          description: "Salary for july",
          time: "04:30 PM",
          amount: "+\$5000",
          color: AppColors.greenColor,
          iconPath: Resources.salary,
          category: TransactionCategory.Income),
      Transaction(
          title: "Transportation",
          description: "Charging Tesla",
          time: "08:30 PM",
          amount: "-\$18",
          color: AppColors.blueColor,
          iconPath: Resources.car,
          category: TransactionCategory.Expense)
    ];
  }

  static List<Transaction> getTodaysTransactions() {
    return [
      Transaction(
          title: "Shopping",
          description: "Buy some grocery",
          time: "10:00 AM",
          amount: "-\$120",
          color: AppColors.orangeColor,
          iconPath: Resources.shopping,
          category: TransactionCategory.Expense),
      Transaction(
          title: "Subscription",
          description: "Disney+ Annual",
          time: "03:30 PM",
          amount: "-\$80",
          color: AppColors.primaryColor,
          iconPath: Resources.subscription,
          category: TransactionCategory.Expense),
      Transaction(
          title: "Food",
          description: "Buy a ramen",
          time: "07:30 PM",
          amount: "-\$32",
          color: AppColors.redColor,
          iconPath: Resources.restaurant,
          category: TransactionCategory.Expense)
    ];
  }
}
