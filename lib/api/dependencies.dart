import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/controllers/budget.controller.dart';
import 'package:ie_montrac/api/controllers/reports.controller.dart';
import 'package:ie_montrac/api/services/events.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  var sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => AppStore(prefs: sharedPreferences));

  Get.lazyPut(() => EventsService());

  // load repositories
  Get.lazyPut(() => Repository(
      httpClient: Get.find<HttpClient>(), appStore: Get.find<AppStore>()));

  //load controllers
  Get.put(() => AuthController(repository: Get.find<Repository>()),
      permanent: true);
  Get.lazyPut(() => ExpenseController(repository: Get.find<Repository>()));
  Get.lazyPut(() => CategoryController(repository: Get.find<Repository>()));
  Get.put(TransactionController(repository: Get.find<Repository>()),
      permanent: true);
  Get.lazyPut(() => IncomeController(repository: Get.find<Repository>()));
  Get.put(() => BudgetController(repository: Get.find<Repository>()),
      permanent: true);
  Get.lazyPut(() => ReportsController(repository: Get.find<Repository>()));
}
