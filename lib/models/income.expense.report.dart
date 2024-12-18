class IncomeExpenseReport {
  final String label;
  final double value;

  IncomeExpenseReport({required this.label, required this.value});

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "value": value,
    };
  }

  factory IncomeExpenseReport.fromJson(Map<String, dynamic> json) {
    return IncomeExpenseReport(
      label: json["label"],
      value: (json["value"] as num).toDouble(),
    );
  }

  //from list
  static List<IncomeExpenseReport> fromList(List<dynamic> list) {
    List<IncomeExpenseReport> items = [];
    for (var item in list) {
      items.add(IncomeExpenseReport.fromJson(item));
    }
    return items;
  }
}
