import 'package:ie_montrac/models/income.expense.report.dart';

class IncomeExpenseReportResponse {
  final double totalIncome;
  final double totalExpense;
  final List<IncomeExpenseReport> expenseReport;
  final List<IncomeExpenseReport> incomeReport;

  IncomeExpenseReportResponse(
      {required this.totalIncome,
      required this.totalExpense,
      required this.expenseReport,
      required this.incomeReport});

  Map<String, dynamic> toJson() {
    return {
      "totalIncome": totalIncome,
      "totalExpense": totalExpense,
      "expenseReport": expenseReport.map((e) => e.toJson()).toList(),
      "incomeReport": incomeReport.map((e) => e.toJson()).toList(),
    };
  }

  factory IncomeExpenseReportResponse.fromJson(Map<String, dynamic> json) {
    return IncomeExpenseReportResponse(
      totalIncome: (json["totalIncome"] as num).toDouble(),
      totalExpense: (json["totalExpense"] as num).toDouble(),
      expenseReport: IncomeExpenseReport.fromList(json["expenseReport"]),
      incomeReport: IncomeExpenseReport.fromList(json["incomeReport"]),
    );
  }
}
