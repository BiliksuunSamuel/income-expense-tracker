import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.dropdown.dart';
import 'package:ie_montrac/components/custom.input.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/components/svg.icon.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/views/app.view.dart';

import '../../theme/app.font.size.dart';
import '../../utils/dimensions.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  bool isRepeatEnabled = false;
  double amount = 0;

  @override
  Widget build(BuildContext context) {
    return AppView(
      backgroundColor: AppColors.redColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.redColor,
                title: AppHeaderTitle(
                  title: "Expense",
                  titleColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.redColor,
                        width: const BoxConstraints.expand().maxWidth,
                        height: Dimensions.getHeight(180),
                        padding: EdgeInsets.all(Dimensions.getPadding(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "How Much",
                              style: AppFontSize.fontSizeTitle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.getFontSize(28)),
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(5),
                            ),
                            Text(
                              "\$0",
                              style: AppFontSize.fontSizeTitle(
                                  fontSize: Dimensions.getFontSize(48),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.getPadding(20)),
                            height: const BoxConstraints.expand().maxHeight,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        Dimensions.getBorderRadius(30)),
                                    topRight: Radius.circular(
                                        Dimensions.getBorderRadius(30)))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomInput(
                                  hintText: "Category",
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                const CustomInput(
                                  hintText: "Description",
                                  minLines: 2,
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                CustomDropdown(
                                    items: ["Wallet"],
                                    selectedValue: "Wallet",
                                    label: "",
                                    onChanged: (String? val) {},
                                    itemLabel: (String item) {
                                      return item;
                                    }),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                InkWell(
                                  child: Container(
                                    height: Dimensions.getHeight(50),
                                    padding: EdgeInsets.all(
                                        Dimensions.getPadding(8)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.getBorderRadius(12)),
                                        border: Border.all(
                                            width: Dimensions.getWidth(0.35),
                                            color:
                                                Colors.grey.withOpacity(0.85))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgIcon(
                                          path: Resources.attachment,
                                          width: Dimensions.getWidth(16),
                                          height: Dimensions.getWidth(16),
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: Dimensions.getWidth(10),
                                        ),
                                        Text(
                                          "Add Attachment",
                                          style: AppFontSize.fontSizeTitle(
                                              fontSize:
                                                  Dimensions.getFontSize(16),
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.getHeight(20),
                                ),
                                // Repeat Toggle
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Repeat',
                                          style: AppFontSize.fontSizeMedium(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Repeat transaction',
                                          style: AppFontSize.fontSizeMedium(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
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
                                  height: Dimensions.getHeight(20),
                                ),
                                PrimaryButton(title: "Continue")
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
