import 'package:get/get.dart';

import '../dtos/http.request.dto.dart';

class HttpClient extends GetConnect implements GetxService {
  late String appBaseUrl;

  static const bool prod = false;
  static const String prodUrl = "https://plankton-app-jznh9.ondigitalocean.app";
  static const String localUrl = "http://192.168.0.174:3303";
  HttpClient({this.appBaseUrl = prod ? prodUrl : localUrl}) {
    timeout = const Duration(seconds: 30);
    baseUrl = appBaseUrl;
  }

  Future<dynamic> postRequest(HttpRequestDto request) async {
    try {
      var response = await post(request.url, request.data,
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer ${request.token}"
          },
          query: request.params);
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  Future<dynamic> putRequest(HttpRequestDto request) async {
    try {
      var response = await put(
        request.url,
        request.data,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${request.token}"
        },
      );
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  Future<dynamic> deleteRequest(HttpRequestDto request) async {
    try {
      var response = await delete(
        request.url,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${request.token}"
        },
      );
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  Future<dynamic> patchRequest(HttpRequestDto request) async {
    try {
      var response = await patch(
        request.url,
        request.data,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer ${request.token}"
        },
      );
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  Future<dynamic> getRequest(HttpRequestDto request) async {
    try {
      return await get(request.url, query: request.params, headers: {
        "Authorization": "Bearer ${request.token}",
        "Content-Type": "application/json; charset=UTF-8"
      });
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }
}
