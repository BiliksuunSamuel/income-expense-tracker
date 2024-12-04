import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';

import '../../components/response.modal.dart';
import '../../dtos/http.request.dto.dart';
import '../../enums/dialog.variants.dart';
import '../../enums/transaction.type.dart';
import '../../models/auth.response.dart';
import '../../models/category.dart';
import '../../models/transaction.request.dart';

class IncomeController extends GetxController {
  final Repository repository;

  IncomeController({required this.repository});

//variables
  bool loading = false;
  var descriptionController = TextEditingController();
  var amountController = TextEditingController();
  bool repeatTransaction = false;
  String? repeatFrequency;
  DateTime? repeatEndDate = DateTime.now();
  AuthResponse? authResponse;

  //
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
          type: TransactionType.Income.name,
          category: category.title,
          account: "Default",
          currency: "GHS",
          repeatTransaction: repeatTransaction,
          repeatFrequency: repeatFrequency,
          repeatInterval: "1",
          repeatTransactionEndDate: repeatEndDate?.toString(),
          invoice: invoice,
          invoiceFileName: invoiceFileName,
          invoiceFileType: invoiceFileType);
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
