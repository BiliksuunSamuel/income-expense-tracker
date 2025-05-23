import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/enums/dialog.variants.dart';
import 'package:ie_montrac/enums/transaction.type.dart';
import 'package:ie_montrac/models/auth.response.dart';

import '../../components/response.modal.dart';
import '../../dtos/budget.for.dropdown.dart';
import '../../models/category.dart';
import '../../models/transaction.dart';
import '../../models/transaction.request.dart';

class ExpenseController extends GetxController {
  final Repository repository;

  ExpenseController({required this.repository});

  //variables
  bool loading = false;
  var descriptionController = TextEditingController();
  var amountController = TextEditingController();
  bool repeatTransaction = false;
  String? repeatFrequency;
  DateTime? repeatEndDate = DateTime.now();
  AuthResponse? authResponse;
  BudgetForDropdown? selectedBudget;
  List<BudgetForDropdown> budgets = [];
  Transaction? transaction;
  bool isAddCategory = false;
  var categoryController = TextEditingController();

  //set is add category
  void setIsAddCategory(bool value) {
    isAddCategory = value;
    update();
  }

  //get transaction by id
  Future<void> getTransactionById(String id) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request =
          HttpRequestDto("/api/transactions/$id", token: authResponse?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }

      transaction = Transaction.fromJson(res.data);
      descriptionController.text = transaction?.description ?? "";
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

  //handle set budget
  void setBudget(BudgetForDropdown budget) {
    selectedBudget = budget;
    update();
  }

  //handle get budgets
  Future<void> getBudgets() async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request =
          HttpRequestDto("/api/budgets/dropdown", token: authResponse?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      loading = false;
      budgets = BudgetForDropdown.listFromJson(res.data);
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //edit transaction
  Future<void> updateTransaction(Category category, String invoice,
      invoiceFileName, invoiceFileType) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var data = TransactionRequest(
              amount: amountController.text.replaceAll(",", ""),
              description: descriptionController.text,
              type: TransactionType.Expense.name,
              category: category.title,
              account: "Default",
              currency: authResponse?.user?.currency!,
              repeatTransaction: repeatTransaction,
              repeatFrequency: repeatFrequency,
              repeatInterval: "1",
              repeatTransactionEndDate: repeatEndDate?.toString(),
              invoice: invoice,
              invoiceFileName: invoiceFileName,
              invoiceFileType: invoiceFileType,
              budgetId: selectedBudget?.id)
          .toJson();
      var request = HttpRequestDto("/api/transactions/${transaction?.id}",
          token: authResponse?.token, data: data);
      var res = await repository.patchAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
        message: res.message ?? "Transaction added successfully",
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

  //add transaction
  Future<void> addTransaction(
      Category? category,
      String invoice,
      invoiceFileName,
      invoiceFileType,
      Future<void> Function()? refreshCategory) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var transaction = TransactionRequest(
          amount: amountController.text.replaceAll(",", ""),
          description: descriptionController.text,
          type: TransactionType.Expense.name,
          category: category?.title ?? categoryController.text,
          account: "Default",
          currency: authResponse?.user?.currency!,
          repeatTransaction: repeatTransaction,
          repeatFrequency: repeatFrequency,
          repeatInterval: "1",
          repeatTransactionEndDate: repeatEndDate?.toString(),
          invoice: invoice,
          invoiceFileName: invoiceFileName,
          invoiceFileType: invoiceFileType,
          budgetId: selectedBudget?.id);
      var request = HttpRequestDto("/api/transactions",
          token: authResponse?.token, data: transaction.toJson());
      var res = await repository.postAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      loading = false;
      descriptionController.clear();
      amountController.clear();
      repeatFrequency = null;
      repeatEndDate = DateTime.now();
      repeatTransaction = false;
      categoryController.clear();
      isAddCategory = false;
      update();
      if (refreshCategory != null) {
        await refreshCategory();
      }
      Get.dialog(ResponseModal(
        message: res.message ?? "Transaction added successfully",
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

  //set repeat frequency
  void setRepeatFrequency(String? value) {
    repeatFrequency = value;
    update();
  }

  //set repeat end date
  void setRepeatEndDate(DateTime value) {
    repeatEndDate = value;
    update();
  }

  //set repeat transaction
  void setRepeatTransaction(bool value) {
    repeatTransaction = value;
    update();
  }

  //handle get auth user
  Future<void> getAuthUser() async {
    authResponse = await repository.getAuthUser();
    update();
  }

  //on init
  @override
  void onInit() async {
    await getAuthUser();
    super.onInit();
  }
}
