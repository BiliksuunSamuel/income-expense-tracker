import 'package:ie_montrac/enums/transaction.category.dart';
import 'package:ie_montrac/helper/resources.dart';

class FinancialReport {
  final String period;
  final TransactionCategory category;
  final String title;
  final String amount;
  final String description;
  final String expenseType;
  final String expenseIcon;
  final String totalAmount;

  FinancialReport(
      {required this.period,
      required this.category,
      required this.title,
      required this.amount,
      required this.description,
      required this.expenseType,
      required this.expenseIcon,
      required this.totalAmount});

  static List<FinancialReport> getFinancialReportData() {
    return [
      FinancialReport(
          period: "This Month",
          category: TransactionCategory.Expense,
          title: "You Spend",
          amount: "\$120",
          description: "and your biggest spending is from",
          expenseType: "Shopping",
          expenseIcon: Resources.shopping,
          totalAmount: "\$332"),
      FinancialReport(
          period: "This Month",
          category: TransactionCategory.Income,
          title: "You Earned",
          amount: "\$5000",
          description: "your biggest Income is from",
          expenseType: "Salary",
          expenseIcon: Resources.shopping,
          totalAmount: "\$5000"),
    ];
  }
}
