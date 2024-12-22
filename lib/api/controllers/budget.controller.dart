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
import 'package:ie_montrac/utils/utilities.dart';

import '../../models/transaction.dart';

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
  Budget? budget;
  //edit controllers
  var amountEditController = TextEditingController();
  var budgetTitleEditController = TextEditingController();
  BudgetCategory? selectedEditCategory;
  String? budgetStatus;
  var statusFilter = RxString("All");
  List<Transaction> budgetTransactions = [];

  //set status filter
  void setStatusFilter(String? status) {
    statusFilter.value = status!;
    update();
  }

  //set selected edit category
  void setSelectedEditCategory(BudgetCategory? category) {
    selectedEditCategory = category;
    update();
  }

  //get budget status
  void setBudgetStatus(String? status) {
    budgetStatus = status;
    update();
  }

  //get budget transactions
  Future<void> getBudgetTransactions(String budgetId) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto("/api/transactions/budget/$budgetId",
          token: authResponse?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      budgetTransactions = Transaction.fromJsonList(res.data);
      loading = false;
      update();
    } catch (e) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //get budget by id
  Future<void> getBudgetById(String id) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request =
          HttpRequestDto("/api/budgets/$id", token: authResponse!.token);
      var response = await repository.getAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }

      budget = Budget.fromJson(response.data);
      amountEditController.text = budget!.amount.toString();
      budgetTitleEditController.text = budget!.title;
      budgetStatus = budget!.status;
      selectedEditCategory = categories
          .firstWhereOrNull((element) => element.id == budget!.categoryId);
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
        "status": "All".equals(statusFilter.value) ? null : statusFilter.value
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

  //handle delete budget
  Future<void> deleteBudget(String id) async {
    try {
      loading = true;
      update();
      await getAuthUser();
      var request =
          HttpRequestDto("/api/budgets/$id", token: authResponse!.token);
      var response = await repository.deleteAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }
      await filterBudgets(0);
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

  //handle update budget
  Future<void> updateBudget(
      {required bool receiveAlert,
      required double receiveAlertPercentage}) async {
    try {
      loading = true;
      update();
      await getAuthUser();

      var data = BudgetRequest(
              title: budgetTitleEditController.text,
              description: selectedEditCategory?.description ?? "",
              category: selectedEditCategory?.title ?? "",
              amount: amountEditController.text.replaceAll(",", ""),
              receiveAlert: receiveAlert,
              receiveAlertPercentage: receiveAlertPercentage,
              categoryId: selectedEditCategory?.id ?? "",
              status: budgetStatus)
          .toJson();
      var request = HttpRequestDto("/api/budgets/${budget!.id}",
          data: data, token: authResponse!.token);

      var response = await repository.patchAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }

      budget = Budget.fromJson(response.data);
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
              receiveAlertPercentage: receiveAlertPercentage,
              categoryId: selectedCategory?.id ?? "",
              status: budgetStatus)
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
      Get.dialog(ResponseModal(
        message: response.message,
        variant: DialogVariant.Success,
      ));
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
      var request = HttpRequestDto(
        "/api/budget-categories",
        token: authResponse!.token,
      );
      var response = await repository.getAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(message: response.message!));
        return;
      }
      categories = BudgetCategory.fromJsonList(response.data);
      if (budget != null) {
        selectedEditCategory = categories
            .firstWhereOrNull((element) => element.id == budget!.categoryId);
      }
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
