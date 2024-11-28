import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';

import 'app.store.dart';
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
}
