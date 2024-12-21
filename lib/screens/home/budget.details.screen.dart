import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/bottom-sheet/action.confirmation.bottom.sheet.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/utils/utilities.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../api/controllers/budget.controller.dart';
import '../../theme/app.colors.dart';
import '../../theme/app.font.size.dart';
import '../../utils/dimensions.dart';
import 'budget.edit.screen.dart';

class BudgetDetailsScreen extends StatefulWidget {
  const BudgetDetailsScreen({super.key});

  @override
  State<BudgetDetailsScreen> createState() => _BudgetDetailsScreenState();
}

class _BudgetDetailsScreenState extends State<BudgetDetailsScreen> {
  //handle init
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  //handle load data
  void _loadData() async {
    var controller = Get.find<BudgetController>();
    var id = Get.arguments["id"];
    await controller.getBudgetById(id);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BudgetController(repository: Get.find()),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: AppView(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        title: AppHeaderTitle(
                          title: "Budget Details",
                          rightComponent: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return ActionConfirmationBottomSheet(
                                        onDecline: () {
                                          Navigator.pop(ctx);
                                        },
                                        onApprove: () async {
                                          Navigator.pop(ctx);
                                          await controller.deleteBudget(
                                              controller.budget!.id);
                                        },
                                        title: "Remove this budget?",
                                        message:
                                            "Are you sure you want to remove this budget",
                                      );
                                    });
                              },
                              icon: const SvgIcon(
                                path: Resources.trashIcon,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 8,
                                child: controller.budget == null
                                    ? const Center(
                                        child: EmptyStateView(
                                          message: "Sorry, resource not found",
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        child: ContentContainer(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.getPadding(
                                                          15)),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .getBorderRadius(
                                                                30)),
                                                    border: Border.all(
                                                      width:
                                                          Dimensions.getWidth(
                                                              0.15),
                                                      color: AppColors.textGray,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize: MainAxisSize
                                                        .min, // Ensure the row wraps its content
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .getPadding(8)),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .getWidth(
                                                                          8)),
                                                          color: mapCategoryToColor(
                                                                  controller
                                                                      .budget!
                                                                      .category)
                                                              .withOpacity(
                                                                  0.15),
                                                        ),
                                                        child: SvgIcon(
                                                          path:
                                                              mapCategoryToIcon(
                                                                  controller
                                                                      .budget!
                                                                      .category),
                                                          color:
                                                              mapCategoryToColor(
                                                                  controller
                                                                      .budget!
                                                                      .category),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.getWidth(
                                                                5),
                                                      ),
                                                      Flexible(
                                                        // Use Flexible instead of Expanded
                                                        child: Text(
                                                          controller
                                                              .budget!.category
                                                              .toTitleCase()
                                                              .trim(),
                                                          style: AppFontSize
                                                              .fontSizeTitle(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(20),
                                              ),
                                              Text(
                                                "Remaining",
                                                style:
                                                    AppFontSize.fontSizeTitle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: Dimensions
                                                            .getFontSize(28)),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(10),
                                              ),
                                              Text(
                                                "${controller.authResponse?.user?.currency} ${(controller.budget!.amount - controller.budget!.progressValue).toStringAsFixed(2)}",
                                                style:
                                                    AppFontSize.fontSizeTitle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: Dimensions
                                                            .getFontSize(36)),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(20),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    Dimensions.getBorderRadius(
                                                        20),
                                                  ),
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: controller.budget!
                                                            .progressValue /
                                                        controller
                                                            .budget!.amount,
                                                    color: mapCategoryToColor(
                                                        controller
                                                            .budget!.category),
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(20),
                                              ),
                                              Center(
                                                child: Text(
                                                  "${controller.authResponse?.user?.currency} ${controller.budget!.progressValue.toStringAsFixed(2)} of ${controller.authResponse?.user?.currency} ${controller.budget!.amount.toStringAsFixed(2)}",
                                                  style: AppFontSize
                                                      .fontSizeMedium(
                                                          color: AppColors
                                                              .textGray,
                                                          fontSize: Dimensions
                                                              .getFontSize(24)),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(10),
                                              ),
                                              Divider(
                                                color: Colors.grey
                                                    .withOpacity(0.15),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(10),
                                              ),
                                              Center(
                                                child: Text(
                                                  controller
                                                      .budget!.description,
                                                  style: AppFontSize
                                                      .fontSizeMedium(),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    Dimensions.getHeight(20),
                                              ),
                                              Visibility(
                                                visible: controller
                                                    .budget!.limitExceeded,
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.getPadding(
                                                          10)),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.redColor,
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .getBorderRadius(
                                                                  20))),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SvgIcon(
                                                        path: Resources.warning,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.getWidth(
                                                                10),
                                                      ),
                                                      Text(
                                                        "You've exceeded the limit",
                                                        style: AppFontSize
                                                            .fontSizeSmall(
                                                                color: AppColors
                                                                    .bodyBackgroundColor),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                            Expanded(
                                flex: 2,
                                child: ContentContainer(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      PrimaryButton(
                                        title: "Edit",
                                        onPressed: () {
                                          Get.to(() => const BudgetEditScreen(),
                                              arguments: {
                                                "id": controller.budget!.id
                                              });
                                        },
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: controller.loading,
                    child: const Loader(),
                  )
                ],
              ),
            ),
          );
        });
  }
}
