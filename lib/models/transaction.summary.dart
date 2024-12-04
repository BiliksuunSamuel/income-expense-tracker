class TransactionSummary {
  final double income;
  final double expense;

  TransactionSummary({required this.income, required this.expense});

  factory TransactionSummary.fromJson(Map<String, dynamic> json) {
    return TransactionSummary(
      income: (json['income'] as num).toDouble(),
      expense: (json['expense'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'expense': expense,
    };
  }
}
