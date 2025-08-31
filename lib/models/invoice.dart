class Invoice {
  final String? id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? createdBy;
  final String subscriptionId;
  final double amount;
  final String status;
  final DateTime? datePaid;
  final DateTime? dueDate;
  final String? paymentReference;
  final String? description;
  final String? invoiceNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? authorizationUrl;

  Invoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.updatedBy,
    required this.createdBy,
    required this.subscriptionId,
    required this.amount,
    required this.status,
    required this.datePaid,
    required this.dueDate,
    required this.paymentReference,
    required this.description,
    this.invoiceNumber,
    this.startDate,
    this.endDate,
    this.authorizationUrl,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json['updatedAt']) : null,
      updatedBy: json['updatedBy'],
      createdBy: json['createdBy'],
      subscriptionId: json['subscriptionId'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      datePaid:
          json["datePaid"] != null ? DateTime.parse(json['datePaid']) : null,
      dueDate: json["dueDate"] != null ? DateTime.parse(json['dueDate']) : null,
      paymentReference: json['paymentReference'],
      description: json['description'],
      invoiceNumber:
          json['invoiceNumber'] ?? json['id']?.substring(0, 8).toUpperCase(),
      startDate:
          json["startDate"] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json["endDate"] != null ? DateTime.parse(json['endDate']) : null,
      authorizationUrl: json['authorizationUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'updatedBy': updatedBy,
      'createdBy': createdBy,
      'subscriptionId': subscriptionId,
      'amount': amount,
      'status': status,
      'datePaid': datePaid?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'paymentReference': paymentReference,
      'description': description,
      'invoiceNumber': invoiceNumber ?? id?.substring(0, 8).toUpperCase(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      "authorizationUrl": authorizationUrl,
    };
  }

  //from list
  static List<Invoice> fromList(List<dynamic> jsonList) {
    return jsonList.map((json) => Invoice.fromJson(json)).toList();
  }
}
