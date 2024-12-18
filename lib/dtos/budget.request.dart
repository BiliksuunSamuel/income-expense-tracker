class BudgetRequest {
  final String title;
  final String description;
  final String category;
  final String amount;
  final bool receiveAlert;
  final double receiveAlertPercentage;
  //
  BudgetRequest(
      {required this.title,
      required this.description,
      required this.category,
      required this.amount,
      required this.receiveAlert,
      required this.receiveAlertPercentage});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'amount': amount,
      'receiveAlert': receiveAlert,
      'receiveAlertPercentage': receiveAlertPercentage.toString()
    };
  }
}
