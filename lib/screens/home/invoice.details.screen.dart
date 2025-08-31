import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/invoice.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/constants/payment.status.dart';
import 'package:ie_montrac/models/invoice.dart';
import 'package:ie_montrac/sections/invoice.details.info.section.dart';
import 'package:ie_montrac/sections/invoice.payment.information.section.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleLoadData();
    });
    super.initState();
  }

  //handle load data
  void handleLoadData() async {
    var inv = Get.arguments['invoice'];
    if (inv != null) {
      var controller = Get.find<InvoiceController>();
      controller.setInvoice(Invoice.fromJson(inv));
    }
  }

  //handle refresh
  Future<void> handleRefresh(String id) async {
    var controller = Get.find<InvoiceController>();
    await controller.getInvoiceById(id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: InvoiceController(repository: Get.find()),
        builder: (controller) {
          return Stack(
            children: [
              RefreshIndicator(
                  child: AppView(
                    backgroundColor: AppColors.bodyBackgroundColor,
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: AppColors.bodyBackgroundColor,
                          pinned: true,
                          automaticallyImplyLeading: false,
                          title: AppHeaderTitle(
                            title: "Invoice Details",
                            titleColor: AppColors.primaryColor,
                          ),
                        ),
                        SliverFillRemaining(
                          child: ContentContainer(
                            backgroundColor: AppColors.bodyBackgroundColor,
                            child: SingleChildScrollView(
                              child: controller.invoice != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        //Invoice Info Section
                                        InvoiceDetailsInfoSection(
                                            invoice: controller.invoice!,
                                            currency: "GHS"),
                                        SizedBox(
                                          height: Dimensions.getHeight(20),
                                        ),

                                        // Payment Details Section
                                        InvoicePaymentInformationSection(
                                            invoice: controller.invoice!),
                                        SizedBox(
                                          height: Dimensions.getHeight(20),
                                        ),
                                        if (controller.invoice != null &&
                                            (controller.invoice!.status !=
                                                    PaymentStatus.completed &&
                                                controller.invoice!.status !=
                                                    PaymentStatus.refunded))
                                          PrimaryButton(
                                              title: "Pay Now",
                                              onPressed: () async {
                                                await controller
                                                    .handlePayInvoice(controller
                                                        .invoice!.id!);
                                              })
                                      ],
                                    )
                                  : EmptyStateView(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onRefresh: () async {
                    if (controller.invoice != null) {
                      await handleRefresh(controller.invoice!.id!);
                    }
                  }),
              if (controller.loading) const Loader()
            ],
          );
        });
  }
}
