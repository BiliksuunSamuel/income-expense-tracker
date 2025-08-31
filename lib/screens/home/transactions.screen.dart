import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/transaction.controller.dart';
import 'package:ie_montrac/api/services/events.service.dart';
import 'package:ie_montrac/bottom-sheet/transactions.filter.bottom.sheet.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/screens/home/financial.report.screen.dart';
import 'package:ie_montrac/sections/grouped.transactions.section.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      if (kDebugMode) {
        print("Connected socketId: ${EventsService.socket.id}");
      }
    });
    super.initState();
  }

  void _loadData() async {
    var controller = Get.find<TransactionController>();
    await controller.getGroupedTransactions(
        type: controller.transactionType.value == "All"
            ? null
            : controller.transactionType.value);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TransactionController(repository: Get.find()),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: AppView(
              body: Stack(
                children: [
                  SafeArea(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: Dimensions.getHeight(60),
                          padding: EdgeInsets.all(Dimensions.getPadding(10)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(
                                  "Recent Transactions",
                                  textAlign: TextAlign.center,
                                  style: AppFontSize.fontSizeMedium(
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.getFontSize(22)),
                                )),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Obx(() =>
                                              TransactionsFilterBottomSheet(
                                                //passing the props no updating in the component
                                                transactionType: controller
                                                    .transactionType.value,
                                                onTransactionTypeChanged:
                                                    (String type) {
                                                  controller
                                                      .setSelectedTransactionType(
                                                          type);
                                                },
                                                onApply: () async {
                                                  Navigator.pop(ctx);
                                                  await controller
                                                      .getGroupedTransactions(
                                                          type: controller
                                                                      .transactionType
                                                                      .value ==
                                                                  "All"
                                                              ? null
                                                              : controller
                                                                  .transactionType
                                                                  .value);
                                                },
                                              ));
                                        });
                                  },
                                  child: Icon(
                                    Icons.filter_list_outlined,
                                    size: Dimensions.getIconSize(32),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(Dimensions.getPadding(15)),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const FinancialReportScreen());
                            },
                            splashColor: Colors.transparent,
                            child: Container(
                              padding:
                                  EdgeInsets.all(Dimensions.getPadding(10)),
                              height: Dimensions.getHeight(50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.getBorderRadius(10)),
                                color: AppColors.primaryColor.withOpacity(0.15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "See your financial report",
                                    style: AppFontSize.fontSizeMedium(
                                        color: AppColors.primaryColor),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.primaryColor,
                                    size: Dimensions.getIconSize(24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ContentContainer(
                          padding: Dimensions.getPadding(15),
                          child: Column(
                            children: [
                              GroupedTransactionsSection(
                                title: "Today",
                                transactions:
                                    controller.groupedTransaction.today,
                              ),
                              SizedBox(height: Dimensions.getHeight(20)),
                              GroupedTransactionsSection(
                                  title: "Yesterday",
                                  transactions:
                                      controller.groupedTransaction.yesterday),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(visible: controller.loading, child: const Loader())
                ],
              ),
            ),
          );
        });
  }
}
