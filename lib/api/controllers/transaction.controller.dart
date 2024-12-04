import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/models/auth.response.dart';
import 'package:ie_montrac/models/transaction.chart.data.dart';
import 'package:ie_montrac/models/transaction.summary.dart';

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
