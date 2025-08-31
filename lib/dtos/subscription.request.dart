class SubscriptionRequest {
  final String billingPlanId;
  final String billingFrequency;

  SubscriptionRequest({
    required this.billingPlanId,
    required this.billingFrequency,
  });

  Map<String, dynamic> toJson() {
    return {
      'billingPlanId': billingPlanId,
      'billingFrequency': billingFrequency,
    };
  }
}
