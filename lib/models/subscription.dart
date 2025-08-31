import 'billing.plan.dart';

class Subscription {
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String planTitle;
  final BillingPlan? plan;
  final int maxNumberOfTransactions;
  final String? status;
  final String? id;

  Subscription({
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.planTitle,
    required this.plan,
    this.maxNumberOfTransactions = 0,
    this.status,
    this.id,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool,
      planTitle: json['planTitle'] as String,
      plan: json['plan'] == null
          ? null
          : BillingPlan.fromJson(json['plan'] as Map<String, dynamic>),
      maxNumberOfTransactions: json['maxNumberOfTransactions'] ?? 0,
      status: json['status'] as String?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
      'planTitle': planTitle,
      'plan': plan == null ? null : plan!.toJson(),
      'maxNumberOfTransactions': maxNumberOfTransactions,
      'status': status,
      'id': id,
    };
  }
}
