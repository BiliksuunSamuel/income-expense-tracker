import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/enums/dialog.variants.dart';
import 'package:ie_montrac/models/billing.plan.dart';

class BillingPlanController extends GetxController {
  final Repository repository;
  BillingPlanController({required this.repository});

  //variables
  List<BillingPlan> billingPlans = [];
  var loading = false;
  BillingPlan? selectedBillingPlan;
  //

  //Set selected billing plan
  void setSelectedBillingPlan(BillingPlan? plan) {
    selectedBillingPlan = plan;
    update();
  }

  //Get Billing Plans
  Future<void> getBillingPlans() async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();
      var request =
          HttpRequestDto("/api/billing-plans", token: authUser?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
            ResponseModal(message: res.message, variant: DialogVariant.Error));
      }
      billingPlans = BillingPlan.fromList(res.data);
      loading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching billing plans: $e");
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
          message: "Sorry,an error occurred", variant: DialogVariant.Error));
    }
  }

  //Get Billing Plan by ID
  Future<void> getBillingPlanById(String id) async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();
      var request =
          HttpRequestDto("/api/billing-plans/$id", token: authUser?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
            ResponseModal(message: res.message, variant: DialogVariant.Error));
      }
      selectedBillingPlan = BillingPlan.fromJson(res.data);
      loading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching billing plan by ID: $e");
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
          message: "Sorry,an error occurred", variant: DialogVariant.Error));
    }
  }
}
