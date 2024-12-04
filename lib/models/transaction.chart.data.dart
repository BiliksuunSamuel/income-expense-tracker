class TransactionChartData {
  final String type;
  final double amount;

  TransactionChartData({required this.type, required this.amount});

  factory TransactionChartData.fromJson(Map<String, dynamic> json) {
    return TransactionChartData(
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
    };
  }

  //list
  static List<TransactionChartData> fromListJson(List<dynamic> json) {
    return json == null
        ? <TransactionChartData>[]
        : json.map((value) => TransactionChartData.fromJson(value)).toList();
  }
}
