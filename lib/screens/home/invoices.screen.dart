import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/invoice.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/invoice.card.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/routes/app.routes.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../api/repositories/repository.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  // on init state
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleLoadData();
    });
    super.initState();
  }

  //handle load data
  void handleLoadData({int pageIndex = 0}) async {
    var controller = Get.find<InvoiceController>();
    await controller.getInvoices(pageIndex: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: InvoiceController(repository: Get.find<Repository>()),
        builder: (controller) {
          return Stack(
            children: [
              RefreshIndicator(
                child: AppView(
                  backgroundColor: AppColors.bodyBackgroundColor,
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        elevation: 0,
                        backgroundColor: AppColors.bodyBackgroundColor,
                        title: AppHeaderTitle(
                          title: "Invoices",
                          rightComponent: (controller.pageSize > 10)
                              ? IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.filter_list,
                                    size: Dimensions.getIconSize(22),
                                  ))
                              : null,
                        ),
                      ),
                      SliverFillRemaining(
                        child: ContentContainer(
                            backgroundColor: AppColors.bodyBackgroundColor,
                            padding: Dimensions.getPadding(15),
                            child: controller.invoices.isEmpty
                                ? EmptyStateView(
                                    message:
                                        "You currently do not have any invoices",
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: controller.invoices.length,
                                    itemBuilder: (BuildContext btx, index) {
                                      var invoice = controller.invoices[index];
                                      return InvoiceCard(
                                        invoice: invoice,
                                        currency: controller
                                                .authUser?.user?.currency ??
                                            "GHS",
                                        onTap: () {
                                          Get.toNamed(
                                              AppRoutes.invoiceDetailsScreen,
                                              arguments: {
                                                "invoice": invoice.toJson()
                                              });
                                        },
                                      );
                                    })),
                      )
                    ],
                  ),
                ),
                onRefresh: () async {
                  handleLoadData();
                },
              ),
              if (controller.loading) const Loader()
            ],
          );
        });
  }
}
