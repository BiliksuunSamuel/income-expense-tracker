class AppOptions {
  static const List<String> transactionRepeatFrequencies = [
    "Daily",
    "Weekly",
    "Monthly",
    "Yearly"
  ];

  static const List<String> financialReportPeriods = [
    "Custom",
    "Month",
    "Year"
  ];

  static const List<String> transactionTypes = [
    "All",
    "Income",
    "Expense",
  ];

  static const List<String> budgetStatuses = [
    "Active",
    "Closed",
  ];

  static const List<String> budgetStatusFilters = ["All", "Active", "Closed"];
}
