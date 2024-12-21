class Budget {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String category;
  final bool receiveAlert;
  final double receiveAlertPercentage;
  final bool limitExceeded;
  final double progressValue;
  final String? categoryId;
  final String? status;

  Budget(
      {required this.id,
      required this.title,
      required this.description,
      required this.amount,
      required this.category,
      required this.receiveAlert,
      required this.receiveAlertPercentage,
      required this.limitExceeded,
      required this.progressValue,
      this.categoryId,
      this.status});

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        amount: json['amount']?.toDouble() ?? 0,
        category: json['category'],
        receiveAlert: json['receiveAlert'] ?? false,
        receiveAlertPercentage: json['receiveAlertPercentage']?.toDouble() ?? 0,
        limitExceeded: json['limitExceeded'] ?? false,
        progressValue: json['progressValue']?.toDouble() ?? 0,
        categoryId: json['categoryId'],
        status: json['status']);
  }

  //list
  static List<Budget> fromJsonList(List list) {
    return list.map((item) => Budget.fromJson(item)).toList();
  }
}
