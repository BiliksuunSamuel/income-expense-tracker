import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/models/auth.response.dart';
import 'package:ie_montrac/models/income.expense.report.response.dart';

class ReportsController extends GetxController {
  final Repository repository;

  ReportsController({required this.repository});

  //variables
  AuthResponse? authResponse;
  IncomeExpenseReportResponse reports = IncomeExpenseReportResponse(
      totalIncome: 0, totalExpense: 0, expenseReport: [], incomeReport: []);
  bool loading = false;

  //get reports
  Future<void> getReports({DateTime? from, DateTime? to}) async {
    try {
      loading = true;
      await getAuthUser();
      update();
      var request = HttpRequestDto("/api/reports/financial-report-summary",
          token: authResponse!.token,
          params: {
            "startDate": from?.toIso8601String(),
            "endDate": to?.toIso8601String(),
          });
      var response = await repository.getAsync(request);
      if (!response.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: response.message,
        ));
      }
      reports = IncomeExpenseReportResponse.fromJson(response.data);
      loading = false;
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry, an error occurred",
      ));
    }
  }

//get auth data
  Future<void> getAuthUser() async {
    authResponse = await repository.getAuthUser();
    update();
  }
}
