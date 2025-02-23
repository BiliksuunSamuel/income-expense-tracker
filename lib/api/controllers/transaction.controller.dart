import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/enums/dialog.variants.dart';
import 'package:ie_montrac/models/auth.response.dart';
import 'package:ie_montrac/models/category.dart';
import 'package:ie_montrac/models/grouped.transaction.dart';
import 'package:ie_montrac/models/transaction.chart.data.dart';
import 'package:ie_montrac/models/transaction.summary.dart';
import 'package:ie_montrac/utils/utilities.dart';

import '../../dtos/http.request.dto.dart';
import '../../dtos/paged.results.dto.dart';
import '../../models/transaction.dart';

class TransactionController extends GetxController {
  final Repository repository;

  TransactionController({required this.repository});

  //variables
  bool loading = false;
  AuthResponse? authResponse;
  List<Transaction> recentTransactions = [];
  List<Transaction> allTransactions = [];
  int page = 1;
  int pageSize = 10;
  int totalCount = 0;
  int totalPages = 0;
  Transaction? transaction;
  TransactionSummary summary = TransactionSummary(income: 0, expense: 0);
  List<TransactionChartData> chartData = [];
  GroupedTransaction groupedTransaction =
      GroupedTransaction(today: [], yesterday: []);
  Category? selectedCategory;
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  List<Category> categories = [];
  bool transactionDeleted = false;

  //set selected Category
  void setSelectedCategory(Category? category) {
    selectedCategory = category;
    update();
  }

  //prop not updating in component UI
  var transactionType = RxString("All");

  //
  //set selected transaction type;
  void setSelectedTransactionType(String type) {
    transactionType.value = type;
    update();
  }

  void resetFilter() async {
    transactionType.value = "All";
    selectedCategory = null;
    startDateController.clear();
    endDateController.clear();
    update();
    await getAllTransactions(pageIndex: 0);
  }

  Future<void> applyFilter() async {
    await getAllTransactions(pageIndex: 0);
  }

  //delete Transaction
  Future<void> deleteTransaction(String id) async {
    try {
      loading = true;
      update();
      await getAuthUser();
      var request =
          HttpRequestDto("/api/transactions/$id", token: authResponse?.token);
      var res = await repository.deleteAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(message: res.message));
      }
      loading = false;
      transactionDeleted = true;
      update();
      Get.dialog(ResponseModal(
        message: res.message ?? "Transaction Removed",
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
      var request =
          HttpRequestDto("/api/categories", token: authResponse?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(message: res.message));
      }
      categories = Category.fromJsonList(res.data);
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

  //get grouped transactions
  Future<void> getGroupedTransactions({String? type}) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto(
        "/api/transactions/grouped",
        token: authResponse?.token,
        params: {
          "type": type,
        },
      );
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      groupedTransaction = GroupedTransaction.fromJson(res.data);
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

  //get transaction chart data
  Future<void> getTransactionChartData(String period) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto("/api/transactions/chart",
          params: {
            "period": period,
          },
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
      chartData = TransactionChartData.fromListJson(res.data);
      //if the chartData length is less than 2,padd the beginning of the list with a dummy data and end of the list with a dummy data
      if (chartData.length < 2) {
        var type = chartData.firstOrNull?.type;
        chartData.insert(0, TransactionChartData(amount: 0, type: type ?? ""));
        chartData.add(TransactionChartData(type: type ?? "", amount: 0));
      }
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

  //get all transactions
  Future<void> getAllTransactions({int pageIndex = 0}) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto("/api/transactions",
          token: authResponse?.token,
          params: {
            "page": "${pageIndex + 1}",
            "pageSize": pageSize.toString(),
            "startDate": startDateController.text,
            "endDate": endDateController.text,
            "category": selectedCategory?.title,
            "type": transactionType.value.equals("All")
                ? null
                : transactionType.value,
          });
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      var results = PagedResults.fromJson(res.data, Transaction.fromJson);
      if (pageIndex == 0) {
        allTransactions = results.results;
      } else {
        allTransactions.addAll(results.results);
      }
      page = results.page;
      pageSize = results.pageSize;
      totalPages = results.totalPages;
      totalCount = results.totalCount;
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

  //get transaction summary by period
  Future<void> getTransactionSummaryByPeriod(String period) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto("/api/transactions/summary",
          token: authResponse?.token,
          params: {
            "period": period,
          });
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      summary = TransactionSummary.fromJson(res.data);
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

      transactionDeleted = false;
      transaction = Transaction.fromJson(res.data);
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

  //get recent transactions
  Future<void> getRecentTransactions({String period = "Today"}) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto("/api/transactions",
          token: authResponse?.token,
          params: {
            "page": page.toString(),
            "pageSize": "5",
            "period": period,
          });
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        Get.dialog(ResponseModal(
          message: res.message ?? "Sorry,an error occurred",
        ));
        return;
      }
      var results = PagedResults.fromJson(res.data, Transaction.fromJson);
      recentTransactions = results.results;
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

  //get auth user
  Future<void> getAuthUser() async {
    authResponse = await repository.getAuthUser();
    update();
  }

  //init
  @override
  void onInit() async {
    await getAuthUser();
    super.onInit();
  }
}
