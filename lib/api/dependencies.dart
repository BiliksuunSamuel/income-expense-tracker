import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/controllers/budget.controller.dart';
import 'package:ie_montrac/api/controllers/reports.controller.dart';

import 'app.store.dart';
import 'controllers/category.controller.dart';
import 'controllers/expense.controller.dart';
import 'controllers/income.controller.dart';
import 'controllers/transaction.controller.dart';
import 'http.client.dart';
import 'repositories/repository.dart';

Future<void> init() async {
  // load http client
  Get.lazyPut(() => HttpClient());
  Get.lazyPut(() => AppStore());

  // load repositories

  Get.lazyPut(() => Repository(
      httpClient: Get.find<HttpClient>(), appStore: Get.find<AppStore>()));

  //load controllers
  Get.lazyPut(() => AuthController(repository: Get.find<Repository>()));
  Get.lazyPut(() => ExpenseController(repository: Get.find<Repository>()));
  Get.lazyPut(() => CategoryController(repository: Get.find<Repository>()));
  Get.put(TransactionController(repository: Get.find<Repository>()),
      permanent: true);
  Get.lazyPut(() => IncomeController(repository: Get.find<Repository>()));
  Get.lazyPut(() => BudgetController(repository: Get.find<Repository>()));
  Get.lazyPut(() => ReportsController(repository: Get.find<Repository>()));
}
