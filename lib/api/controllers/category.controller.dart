import 'package:get/get.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/models/auth.response.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';

import '../../models/category.dart';
import '../repositories/repository.dart';

class CategoryController extends GetxController {
  final Repository repository;

  CategoryController({required this.repository});

  //variables
  bool loading = false;
  List<Category> categories = [];
  AuthResponse? authResponse;
  Category? selectedCategory;

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

  //get auth user
  Future<void> getAuthUser() async {
    authResponse = await repository.getAuthUser();
    update();
    if (authResponse == null) {
      Get.off(() => const WelcomeScreen());
    }
  }

  //init
  @override
  void onInit() async {
    super.onInit();
    await getAuthUser();
  }
}
