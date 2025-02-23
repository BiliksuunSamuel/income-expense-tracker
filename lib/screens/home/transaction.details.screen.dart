import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/transaction.controller.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/screens/home/edit.expense.screen.dart';
import 'package:ie_montrac/screens/home/edit.income.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/utils/utilities.dart';
import 'package:ie_montrac/views/app.view.dart';

import '../../bottom-sheet/action.confirmation.bottom.sheet.dart';
import '../../components/primary.button.dart';
import '../../components/svg.icon.dart';
import '../../helper/resources.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  String transactionType = "Income";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    super.initState();
  }

  //handle load data
  void _loadData() async {
    var transactionType = Get.arguments["transactionType"];
    setState(() {
      transactionType = transactionType;
    });
    var controller = Get.find<TransactionController>();
    var transactionId = Get.arguments["transactionId"];
    await controller.getTransactionById(transactionId);
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
                  if (controller.transaction != null)
                    Column(
                      children: [
                        // Red header section
                        Container(
                          decoration: BoxDecoration(
                              color: controller.transaction?.type == "Expense"
                                  ? AppColors.redColor
                                  : AppColors.blueColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                      Dimensions.getBorderRadius(30)),
                                  bottomRight: Radius.circular(
                                      Dimensions.getBorderRadius(30)))),
                          child: SafeArea(
                            bottom: false,
                            child: Column(
                              children: [
                                // App bar
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back,
                                            color: Colors.white),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      Text(
                                        'Transaction Details',
                                        style: AppFontSize.fontSizeTitle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return ActionConfirmationBottomSheet(
                                                  title:
                                                      "Remove this transaction?",
                                                  message:
                                                      "Are you sure you want to remove this transaction",
                                                  onDecline: () {
                                                    Navigator.pop(context);
                                                  },
                                                  onApprove: () async {
                                                    Navigator.pop(context);
                                                    await controller
                                                        .deleteTransaction(
                                                            controller
                                                                .transaction!
                                                                .id);
                                                  },
                                                );
                                              });
                                        },
                                        child: const SvgIcon(
                                          path: Resources.trashIcon,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Amount and description
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.getPadding(20),
                                      bottom: Dimensions.getPadding(20),
                                      right: Dimensions.getPadding(20)),
                                  child: Column(
                                    children: [
                                      Text(
                                        "${controller.transaction!.currency} ${controller.transaction!.amount.toStringAsFixed(2)}",
                                        style: AppFontSize.fontSizeTitle(
                                          color: Colors.white,
                                          fontSize: Dimensions.getFontSize(36),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        //'Saturday 4 June 2021   16:20',
                                        longDateTimeString(
                                            controller.transaction!.createdAt),
                                        style: AppFontSize.fontSizeMedium(
                                          color: Colors.white.withOpacity(0.98),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // White content section
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  children: [
                                    Container(
                                      width: Dimensions.deviceWidth * 0.95,
                                      padding: EdgeInsets.all(
                                          Dimensions.getPadding(20)),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.getBorderRadius(15)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 10,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.15),
                                          width: Dimensions.getWidth(1.5),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: _buildInfoColumn(
                                                  'Type',
                                                  controller.transaction!.type
                                                      .toTitleCase())),
                                          Expanded(
                                              flex: 4,
                                              child: _buildInfoColumn(
                                                  'Category',
                                                  controller
                                                      .transaction!.category
                                                      .toTitleCase())),
                                        ],
                                      ),
                                    ),
                                    // Type, Category, Wallet section

                                    SizedBox(
                                      height: Dimensions.getHeight(20),
                                    ),

                                    // Description section
                                    Text(
                                      'Description',
                                      style: AppFontSize.fontSizeMedium(
                                          color: Colors.grey,
                                          fontSize: Dimensions.getFontSize(16)),
                                    ),
                                    Text(
                                      controller.transaction!.description,
                                      style: AppFontSize.fontSizeMedium(
                                          fontSize: Dimensions.getFontSize(16)),
                                    ),
                                    SizedBox(height: Dimensions.getHeight(20)),
                                    // Attachment section
                                    Visibility(
                                        visible: controller
                                                .transaction!.invoiceUrl !=
                                            null,
                                        child: Text(
                                          'Attachment',
                                          style: AppFontSize.fontSizeMedium(
                                            color: Colors.grey,
                                            fontSize:
                                                Dimensions.getFontSize(18),
                                          ),
                                        )),
                                    Visibility(
                                      visible:
                                          controller.transaction!.invoiceUrl !=
                                              null,
                                      child: SizedBox(
                                          height: Dimensions.getHeight(10)),
                                    ),
                                    if (controller.transaction!.invoiceUrl !=
                                        null)
                                      Container(
                                        height: Dimensions.getHeight(150),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.getBorderRadius(15)),
                                            image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .transaction!.invoiceUrl!),
                                                fit: BoxFit.cover)),
                                      ),
                                    SizedBox(height: Dimensions.getHeight(20)),
                                    // Edit button
                                    if (!controller.transactionDeleted)
                                      PrimaryButton(
                                        title: "Edit",
                                        onPressed: () {
                                          if ("Income".equals(
                                              controller.transaction!.type)) {
                                            Get.to(() => EditIncomeScreen(),
                                                arguments: {
                                                  "transactionId": controller
                                                      .transaction!.id,
                                                  "transactionType": "Income"
                                                });
                                          } else {
                                            Get.to(() => EditExpenseScreen(),
                                                arguments: {
                                                  "transactionId": controller
                                                      .transaction!.id,
                                                  "transactionType": "Expense"
                                                });
                                          }
                                        },
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  //adding loader
                  Visibility(visible: controller.loading, child: const Loader())
                ],
              ),
            ),
          );
        });
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isNotEmpty ? value : "",
          style: TextStyle(
            fontSize: Dimensions.getFontSize(14),
            fontWeight: FontWeight.normal,
          ),
          softWrap: true,
          maxLines: null, // Allows unlimited lines
        )
      ],
    );
  }
}
