import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/dtos/paged.results.dto.dart';
import 'package:ie_montrac/enums/dialog.variants.dart';
import 'package:ie_montrac/models/auth.response.dart';
import 'package:ie_montrac/models/invoice.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../repositories/repository.dart';

class InvoiceController extends GetxController {
  final Repository repository;
  final AppLinks _appLinks = AppLinks();
  InvoiceController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    _listenForIncomingLinks();
  }

  //variables
  var loading = false;
  var page = 1;
  var totalPages = 0;
  var totalCount = 0;
  var pageSize = 10;
  List<Invoice> invoices = [];
  AuthResponse? authUser;
  Invoice? invoice;
  StreamSubscription? _linkSub;

  // Stream subscription for incoming links
  void _listenForIncomingLinks() async {
    _linkSub = _appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri?.scheme == 'iemontrac' && uri?.host == 'payment-success') {
        //get project id
        var invoiceId = uri?.queryParameters['invoiceId'];
        if (invoiceId != null) {
          await getInvoiceById(invoiceId);

          Get.dialog(
            ResponseModal(
              message:
                  "Payment completed successfully. Thank you for your payment!",
              variant: DialogVariant.Success,
            ),
          );
        }
        // Optional: Navigate to project details or refresh list
        return;
      }
      if (uri?.scheme == 'iemontrac' && uri?.host == 'payment-failed') {
        Get.dialog(
          ResponseModal(
            message: "Payment failed. Please try again.",
            variant: DialogVariant.Error,
          ),
        );
        return;
      }
    }, onError: (err) {
      if (kDebugMode) {
        print("Error in incoming link stream: $err");
      }
    });
  }

  @override
  void onClose() {
    _linkSub?.cancel();
    super.onClose();
  }

  //handle pay invoice
  Future<void> handlePayInvoice(String invoiceId) async {
    try {
      loading = true;
      update();
      var authInfo = await repository.getAuthUser();
      var token = authInfo?.token;
      var request =
          HttpRequestDto("/api/invoices/pay/$invoiceId", token: token);
      var res = await repository.postAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(
            ResponseModal(message: res.message, variant: DialogVariant.Error));
      }
      loading = false;
      update();
      invoice = Invoice.fromJson(res.data);
      var authorizationUrl = invoice?.authorizationUrl;
      if (authorizationUrl != null) {
        await launchUrlString(authorizationUrl,
            mode: LaunchMode.externalApplication);
        return;
      }
      Get.dialog(ResponseModal(
        message: "Sorry, an error occurred",
        variant: DialogVariant.Error,
      ));
    } catch (e) {
      if (kDebugMode) {
        print("Error in handlePayInvoice: $e");
      }
      Get.dialog(ResponseModal(
          message: "Sorry, an error occurred", variant: DialogVariant.Error));
    }
  }

  //get invoices
  Future<void> getInvoices({int pageIndex = 0}) async {
    try {
      loading = true;
      update();
      var authInfo = await repository.getAuthUser();
      authUser = authInfo;
      update();
      var request = HttpRequestDto("/api/invoices/client",
          token: authInfo?.token,
          params: {
            "page": "${pageIndex + 1}",
            "pageSize": "$pageSize",
          });

      var response = await repository.getAsync(request);

      if (!response.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
            message: response.message, variant: DialogVariant.Error));
      }

      var results = PagedResults.fromJson(response.data, Invoice.fromJson);
      if (pageIndex == 0) {
        invoices = results.results;
      } else {
        invoices.addAll(results.results);
      }
      totalPages = results.totalPages;
      totalCount = results.totalCount;
      page = results.page;
      pageSize = results.pageSize;
      loading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error in getInvoices: $e");
      }
      loading = false;
      update();
      Get.dialog(ResponseModal(
          message: "Sorry, an error occurred", variant: DialogVariant.Error));
    }
  }

  //set invoice
  void setInvoice(Invoice? inv) {
    invoice = inv;
    update();
  }

  //get invoice by id
  Future<void> getInvoiceById(String id) async {
    try {
      loading = true;
      update();
      var authInfo = await repository.getAuthUser();
      var request = HttpRequestDto("/api/invoices/$id", token: authInfo?.token);

      var response = await repository.getAsync(request);

      if (!response.isSuccessful) {
        Get.dialog(ResponseModal(
            message: response.message, variant: DialogVariant.Error));
        return null;
      }

      invoice = Invoice.fromJson(response.data);
      loading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error in getInvoiceById: $e");
      }
      Get.dialog(ResponseModal(
        message: "Sorry, an error occurred",
        variant: DialogVariant.Error,
      ));
    }
  }
}
