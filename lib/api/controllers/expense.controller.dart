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

  //add transaction
  Future<void> addTransaction(Category category, String invoice,
      invoiceFileName, invoiceFileType) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var transaction = TransactionRequest(
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
