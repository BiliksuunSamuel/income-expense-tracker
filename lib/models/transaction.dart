class Transaction {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String type;
  final double amount;
  final int year;
  final int month;
  final String currency;
  final String category;
  final String description;
  final String? invoiceUrl;
  final String userId;
  final bool repeatTransaction;
  final int? repeatInterval;
  final DateTime? repeatTransactionEndDate;
  final String? repeatFrequency;
  final String account;
  final String username;
  final String? invoiceFileName;
  final String? invoiceFileType;
  final String? budgetId;

  Transaction({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.type,
    required this.amount,
    required this.year,
    required this.month,
    required this.currency,
    required this.category,
    required this.description,
    this.invoiceUrl,
    required this.userId,
    required this.repeatTransaction,
    this.repeatInterval,
    this.repeatTransactionEndDate,
    this.repeatFrequency,
    required this.account,
    required this.username,
    this.invoiceFileName,
    this.invoiceFileType,
    this.budgetId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json['updatedAt']) : null,
      type: json['type'],
      amount: json['amount'].toDouble(),
      year: json['year'],
      month: json['month'],
      currency: json['currency'],
      category: json['category'],
      description: json['description'],
      invoiceUrl: json['invoiceUrl'],
      userId: json['userId'],
      repeatTransaction: json['repeatTransaction'],
      repeatInterval: json['repeatInterval'],
      repeatTransactionEndDate: json["repeatTransactionEndDate"] == null
          ? null
          : DateTime.parse(json['repeatTransactionEndDate']),
      repeatFrequency: json['repeatFrequency'],
      account: json['account'],
      username: json['username'],
      invoiceFileName: json['invoiceFileName'],
      invoiceFileType: json['invoiceFileType'],
      budgetId: json['budgetId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'type': type,
      'amount': amount,
      'year': year,
      'month': month,
      'currency': currency,
      'category': category,
      'description': description,
      'invoiceUrl': invoiceUrl,
      'userId': userId,
      'repeatTransaction': repeatTransaction,
      'repeatInterval': repeatInterval,
      'repeatTransactionEndDate': repeatTransactionEndDate?.toIso8601String(),
      'repeatFrequency': repeatFrequency,
      'account': account,
      'username': username,
      'invoiceFileName': invoiceFileName,
      'invoiceFileType': invoiceFileType,
      'budgetId': budgetId,
    };
  }

  //from list
  static List<Transaction> fromJsonList(List list) {
    return list.map((item) => Transaction.fromJson(item)).toList();
  }
}
