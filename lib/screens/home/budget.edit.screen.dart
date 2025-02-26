import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.dropdown.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/components/progress.bar.dart';
import 'package:ie_montrac/constants/app.options.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';

import '../../api/controllers/budget.controller.dart';
import '../../components/custom.input.dart';
import '../../components/custom.number.input.dart';
import '../../models/budget.category.dart';

class BudgetEditScreen extends StatefulWidget {
  const BudgetEditScreen({super.key});

  @override
  State<BudgetEditScreen> createState() => _BudgetEditScreenState();
}

class _BudgetEditScreenState extends State<BudgetEditScreen> {
  bool isRepeatEnabled = false;
  double _progress = 0.45;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleLoadData();
    });
  }

  void _handleLoadData() async {
    var controller = Get.find<BudgetController>();
    var id = Get.arguments['id'];
    await Future.wait(
        [controller.getBudgetById(id ?? ""), controller.getCategories()]);

    var budget = controller.budget;
    if (budget != null) {
      controller.amountEditController.text = budget.amount.toString();
      controller.budgetTitleEditController.text = budget.title;
      setState(() {
        isRepeatEnabled = budget.receiveAlert;
        _progress = budget.receiveAlertPercentage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BudgetController(repository: Get.find()),
        builder: (controller) {
          return AppView(
            backgroundColor: AppColors.primaryColor,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.primaryColor,
                      title: AppHeaderTitle(
                        title: "Edit Budget",
                        titleColor: Colors.white,
                        iconColor: Colors.white,
                      ),
                    ),
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Container(
                                color: AppColors.primaryColor,
                                padding:
                                    EdgeInsets.all(Dimensions.getPadding(20)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "How much do you want to spend?",
                                      style: AppFontSize.fontSizeMedium(
                                          color: Colors.white.withOpacity(0.5),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: Dimensions.getHeight(10),
                                    ),
                                    CustomNumberInput(
                                      controller:
                                          controller.amountEditController,
                                    )
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      Dimensions.getBorderRadius(25),
                                    ),
                                    topLeft: Radius.circular(
                                        Dimensions.getBorderRadius(25))),
                                child: Container(
                                  color: Colors.white,
                                  padding:
                                      EdgeInsets.all(Dimensions.getPadding(20)),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      SizedBox(
                                        height: Dimensions.getHeight(10),
                                      ),
                                      CustomInput(
                                        hintText: "Budget Title",
                                        label: "Budget Title",
                                        controller: controller
                                            .budgetTitleEditController,
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(15),
                                      ),
                                      CustomDropdown(
                                          items: controller.categories,
                                          selectedValue:
                                              controller.selectedEditCategory,
                                          hintText: "Category",
                                          label: "Category",
                                          onChanged:
                                              (BudgetCategory? newValue) {
                                            controller.setSelectedEditCategory(
                                                newValue);
                                          },
                                          itemLabel: (BudgetCategory item) {
                                            return item.title;
                                          }),
                                      SizedBox(
                                        height: Dimensions.getHeight(15),
                                      ),
                                      CustomDropdown(
                                          items: AppOptions.budgetStatuses,
                                          selectedValue:
                                              controller.budgetStatus,
                                          hintText: "Status",
                                          label: "Status",
                                          onChanged: (String? newValue) {
                                            controller
                                                .setBudgetStatus(newValue);
                                          },
                                          itemLabel: (String item) {
                                            return item;
                                          }),
                                      SizedBox(
                                        height: Dimensions.getHeight(15),
                                      ),
                                      Text(
                                        "Receive Alert",
                                        style: AppFontSize.fontSizeMedium(),
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(5),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            "Receive alert when it reaches some point",
                                            style: AppFontSize.fontSizeMedium(
                                                color: AppColors.textGray,
                                                fontSize:
                                                    Dimensions.getFontSize(14)),
                                          )),
                                          SizedBox(
                                            width: Dimensions.getWidth(40),
                                          ),
                                          CupertinoSwitch(
                                            value: isRepeatEnabled,
                                            onChanged: (value) {
                                              setState(() {
                                                isRepeatEnabled = value;
                                              });
                                            },
                                            activeColor: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.getHeight(15),
                                      ),
                                      Visibility(
                                          visible: isRepeatEnabled,
                                          child: ProgressBar(
                                            progress: _progress,
                                            onChange: (double newVal) {
                                              setState(() {
                                                _progress = newVal;
                                              });
                                            },
                                          )),
                                      SizedBox(
                                        height: Dimensions.getHeight(30),
                                      ),
                                      PrimaryButton(
                                          title: "Submit",
                                          onPressed: () async {
                                            await controller.updateBudget(
                                                receiveAlertPercentage:
                                                    _progress,
                                                receiveAlert: isRepeatEnabled);
                                          }),
                                    ],
                                  ),
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
          );
        });
  }
}
