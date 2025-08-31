import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/constants/billing.frequency.dart';
import 'package:ie_montrac/dtos/subscription.request.dart';
import 'package:ie_montrac/enums/dialog.variants.dart';
import 'package:ie_montrac/models/billing.plan.dart';
import 'package:ie_montrac/models/subscription.dart';

import '../../components/response.modal.dart';
import '../../dtos/http.request.dto.dart';

class SubscriptionController extends GetxController {
  final Repository repository;
  SubscriptionController({required this.repository});

  //variables
  Subscription? subscription;
  var loading = false;

  //Set subcription
  void setSubscription(Subscription? sub) {
    subscription = sub;
    update();
  }

  //Get User Active Subscription
  Future<void> getUserActiveSubscription() async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();
      var request = HttpRequestDto(
        "/api/subscriptions/active",
        token: authUser?.token,
      );
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
            ResponseModal(message: res.message, variant: DialogVariant.Error));
      }
      subscription = Subscription.fromJson(res.data);
      loading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user active subscription: $e");
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
          message: "Sorry,an error occurred", variant: DialogVariant.Error));
    }
  }

  //Buy Subscription
  Future<void> buySubscription(BillingPlan billingPlan, bool isAnnual) async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();
      var data = SubscriptionRequest(
              billingPlanId: billingPlan.id,
              billingFrequency:
                  isAnnual ? BillingFrequency.yearly : BillingFrequency.monthly)
          .toJson();
      var request = HttpRequestDto(
        "/api/subscriptions",
        token: authUser?.token,
        data: data,
      );

      var res = await repository.postAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
            ResponseModal(message: res.message, variant: DialogVariant.Error));
      }
      subscription = Subscription.fromJson(res.data);
      loading = false;
      update();
      Get.dialog(ResponseModal(
        message: res.message,
        variant: DialogVariant.Success,
      ));
    } catch (e) {
      if (kDebugMode) {
        print("Error buying subscription: $e");
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
        message: "Sorry,an error occurred",
        variant: DialogVariant.Error,
      ));
    }
  }

  // Get Subscription by Id
  Future<void> getSubscriptionById(String id) async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();
      var request = HttpRequestDto(
        "/api/subscriptions/$id",
        token: authUser?.token,
      );
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
            ResponseModal(message: res.message, variant: DialogVariant.Error));
      }
      subscription = Subscription.fromJson(res.data);
      loading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching subscription by id: $e");
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
          message: "Sorry,an error occurred", variant: DialogVariant.Error));
    }
  }
}
