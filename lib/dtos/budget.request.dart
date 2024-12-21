class BudgetRequest {
  final String title;
  final String description;
  final String category;
  final String amount;
  final bool receiveAlert;
  final double receiveAlertPercentage;
  final String categoryId;
  final String? status;
  //
  BudgetRequest(
      {required this.title,
      required this.description,
      required this.category,
      required this.amount,
      required this.receiveAlert,
      required this.receiveAlertPercentage,
      required this.categoryId,
      required this.status});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'amount': amount,
      'receiveAlert': receiveAlert,
      'receiveAlertPercentage': receiveAlertPercentage.toString(),
      'categoryId': categoryId,
      'status': status
    };
  }
}
