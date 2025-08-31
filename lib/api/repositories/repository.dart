import 'dart:convert';

import 'package:get/get.dart';

import '../../constants/keys.dart';
import '../../dtos/api.response.dto.ts.dart';
import '../../dtos/http.request.dto.dart';
import '../../models/auth.response.dart';
import '../../screens/landing/welcome.screen.dart';
import '../app.store.dart';
import '../http.client.dart';

class Repository extends GetxService {
  final HttpClient httpClient;
  final AppStore appStore;

  Repository({required this.httpClient, required this.appStore});

  //
  Future<AuthResponse?> getAuthUser() async {
    try {
      var data = await appStore.getData(Keys.User);
      if (data != null) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        var response = AuthResponse.fromJson(jsonData);
        return response;
      }
      return null;
    } catch (e) {
      await appStore.removeData(Keys.User);
      return Get.off(() => const WelcomeScreen());
    }
  }

  Future<void> removeFromLocalStorage(String key) async {
    await appStore.removeData(key);
  }

  Future<void> saveAuthUser(AuthResponse authResponse) async {
    Map<String, dynamic> jsonData = {
      "user": authResponse.user!.toJson(),
      "token": authResponse.token,
      "subscription": authResponse.subscription?.toJson()
    };
    String data = jsonEncode(jsonData);
    await appStore.saveData(Keys.User, data);
  }

  Future<ApiResponse> deleteAsync(HttpRequestDto request) async {
    var response = await httpClient.deleteRequest(request);
    var apiResponse = ApiResponse.fromJson(response.body);
    apiResponse.code = response.statusCode;
    return apiResponse;
  }

  Future<ApiResponse> patchAsync(HttpRequestDto request) async {
    var response = await httpClient.patchRequest(request);
    var apiResponse = ApiResponse.fromJson(response.body);
    apiResponse.code = response.statusCode;
    return apiResponse;
  }

  Future<ApiResponse> putAsync(HttpRequestDto request) async {
    var response = await httpClient.putRequest(request);
    var apiResponse = ApiResponse.fromJson(response.body);
    apiResponse.code = response.statusCode;
    return apiResponse;
  }

  Future<ApiResponse> postAsync(HttpRequestDto request) async {
    var response = await httpClient.postRequest(request);
    var apiResponse = ApiResponse.fromJson(response.body);
    apiResponse.code = response.statusCode;
    return apiResponse;
  }

  Future<ApiResponse> getAsync(HttpRequestDto request) async {
    var response = await httpClient.getRequest(request);
    var apiResponse = ApiResponse.fromJson(response.body);
    apiResponse.code = response.statusCode;
    return apiResponse;
  }

  Future<dynamic> getFileAsync(HttpRequestDto request) async {
    var response = await httpClient.getRequest(request);
    return response;
  }
}
