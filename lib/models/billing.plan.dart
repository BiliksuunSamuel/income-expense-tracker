class BillingPlan {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String createdBy;
  final String title;
  final String description;
  final double price;
  final double yearlyDiscount;
  final List<String> features;
  final List<String> unavailableFeatures;
  bool isFree = false;
  final double yearlyPrice;
  final int maxNumberOfTransactions;

  BillingPlan({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.updatedBy,
    required this.createdBy,
    required this.title,
    required this.description,
    required this.price,
    required this.yearlyDiscount,
    required this.features,
    required this.unavailableFeatures,
    required this.yearlyPrice,
    this.isFree = false,
    this.maxNumberOfTransactions = 0,
  });

  factory BillingPlan.fromJson(Map<String, dynamic> json) {
    return BillingPlan(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      updatedBy: json['updatedBy'] as String?,
      createdBy: json['createdBy'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      yearlyDiscount: (json['yearlyDiscount'] as num).toDouble(),
      features: List<String>.from(json['features'] ?? []),
      unavailableFeatures: List<String>.from(json['unavailableFeatures'] ?? []),
      isFree: ((json['price'] as num).toDouble()) == 0.0 ? true : false,
      yearlyPrice: (json['yearlyPrice'] as num).toDouble(),
      maxNumberOfTransactions: json['maxNumberOfTransactions'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'updatedBy': updatedBy,
      'createdBy': createdBy,
      'title': title,
      'description': description,
      'price': price,
      'yearlyDiscount': yearlyDiscount,
      'features': features,
      'unavailableFeatures': unavailableFeatures,
      'yearlyPrice': yearlyPrice,
      'maxNumberOfTransactions': maxNumberOfTransactions,
    };
  }

  //From list
  static List<BillingPlan> fromList(List<dynamic> list) {
    return list
        .map((item) => BillingPlan.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
