import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/dtos/budget.request.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/dtos/paged.results.dto.dart';
import 'package:ie_montrac/enums/dialog.variants.dart';
import 'package:ie_montrac/models/auth.response.dart';
import 'package:ie_montrac/models/budget.category.dart';
import 'package:ie_montrac/models/budget.dart';

class BudgetController extends GetxController {
  final Repository repository;
  BudgetController({required this.repository});

  //variables;
  var loading = false;
  List<BudgetCategory> categories = [];
  List<Budget> budgets = [];
  int page = 1;
  int pageSize = 10;
  int totalCount = 0;
  int totalPage = 0;
  AuthResponse? authResponse;
  var categoryTitleController = TextEditingController();
  var categoryDescriptionController = TextEditingController();
  var budgetTitleController = TextEditingController();
  var amountController = TextEditingController();
  BudgetCategory? selectedCategory;

  //filter budgets
  Future<void> filterBudgets(int pageIndex) async {
    try {
      loading = true;
      update();
      await getAuthUser();
      var request =
          HttpRequestDto("/api/budgets", token: authResponse!.token, params: {
        "page": "${pageIndex + 1}",
        "pageSize": pageSize.toString(),
      });
      var response = await repository.getAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }

      var results = PagedResults.fromJson(response.data, Budget.fromJson);
      if (pageIndex == 0) {
        budgets = results.results;
      } else {
        budgets.addAll(results.results);
      }
      totalCount = results.totalCount;
      totalPage = results.totalPages;
      page = results.page;
      pageSize = results.pageSize;
      loading = false;
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //handle create budget
  Future<void> createBudget(
      {required bool receiveAlert,
      required double receiveAlertPercentage}) async {
    try {
      loading = true;
      update();
      await getAuthUser();

      var data = BudgetRequest(
              title: budgetTitleController.text,
              description: selectedCategory?.description ?? "",
              category: selectedCategory?.title ?? "",
              amount: amountController.text.replaceAll(",", ""),
              receiveAlert: receiveAlert,
              receiveAlertPercentage: receiveAlertPercentage)
          .toJson();
      var request = HttpRequestDto("/api/budgets",
          data: data, token: authResponse!.token);

      var response = await repository.postAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }
      budgetTitleController.clear();
      amountController.clear();
      selectedCategory = null;
      loading = false;
      update();
      Get.dialog(ResponseModal(
          message: response.message, variant: DialogVariant.Success));
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //set selected category
  void setSelectedCategory(BudgetCategory? category) {
    selectedCategory = category;
    update();
  }

  //create category
  Future<void> createCategory() async {
    try {
      loading = true;
      update();
      await getAuthUser();

      var request = HttpRequestDto("/api/budget-categories",
          data: {
            "title": categoryTitleController.text,
            "description": categoryDescriptionController.text
          },
          token: authResponse!.token);

      var response = await repository.postAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }
      categoryTitleController.clear();
      categoryDescriptionController.clear();
      await getCategories();
      loading = false;
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //get categories
  Future<void> getCategories() async {
    try {
      loading = true;
      update();
      await getAuthUser();
      var request =
          HttpRequestDto("/api/budget-categories", token: authResponse!.token);
      var response = await repository.getAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }
      categories = BudgetCategory.fromJsonList(response.data);
      loading = false;
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //get auth user
  Future<void> getAuthUser() async {
    authResponse = await repository.getAuthUser();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    await getAuthUser();
  }
}
