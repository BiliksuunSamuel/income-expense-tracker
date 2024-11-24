import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/bottom-sheet/action.confirmation.bottom.sheet.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

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
  @override
  Widget build(BuildContext context) {
    return AppView(
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
                  title: "Details Budget",
                  rightComponent: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext ctx) {
                              return const ActionConfirmationBottomSheet(
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
                        child: SingleChildScrollView(
                          child: ContentContainer(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        Dimensions.getPadding(20)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.getBorderRadius(20)),
                                      border: Border.all(
                                        width: Dimensions.getWidth(0.15),
                                        color: AppColors.textGray,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize
                                          .min, // Ensure the row wraps its content
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                              Dimensions.getPadding(8)),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.getWidth(8)),
                                            color: AppColors.orangeColor
                                                .withOpacity(0.15),
                                          ),
                                          child: const SvgIcon(
                                            path: Resources.shopping,
                                            color: AppColors.orangeColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.getWidth(5),
                                        ),
                                        Flexible(
                                          // Use Flexible instead of Expanded
                                          child: Text(
                                            "Shopping",
                                            style: AppFontSize.fontSizeTitle(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                Text(
                                  "Remaining",
                                  style: AppFontSize.fontSizeTitle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.getFontSize(28)),
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(10),
                                ),
                                Text(
                                  "\$0",
                                  style: AppFontSize.fontSizeTitle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.getFontSize(52)),
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.getBorderRadius(20),
                                    ),
                                    child: LinearProgressIndicator(
                                      value: 1,
                                      color: AppColors.orangeColor,
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.all(Dimensions.getPadding(10)),
                                  decoration: BoxDecoration(
                                      color: AppColors.redColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.getBorderRadius(20))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SvgIcon(
                                        path: Resources.warning,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: Dimensions.getWidth(10),
                                      ),
                                      Text(
                                        "You've exceeded the limit",
                                        style: AppFontSize.fontSizeSmall(
                                            color:
                                                AppColors.bodyBackgroundColor),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: ContentContainer(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                title: "Edit",
                                onPressed: () {
                                  Get.to(() => const BudgetEditScreen());
                                },
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
