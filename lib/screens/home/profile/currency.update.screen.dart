import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.dropdown.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/constants/currencies.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../../models/currency.dart';

class CurrencyUpdateScreen extends StatefulWidget {
  const CurrencyUpdateScreen({super.key});

  @override
  State<CurrencyUpdateScreen> createState() => _CurrencyUpdateScreenState();
}

class _CurrencyUpdateScreenState extends State<CurrencyUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthController(repository: Get.find()),
        builder: (controller) {
          return AppView(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      backgroundColor: AppColors.bodyBackgroundColor,
                      title: const AppHeaderTitle(
                        title: "Update Currency",
                        leftComponent: SizedBox(),
                      ),
                    ),
                    SliverFillRemaining(
                      child: ContentContainer(
                        child: ListView(
                          children: [
                            Center(
                              child: Text(
                                "Select your preferred currency",
                                style: AppFontSize.fontSizeMedium(
                                    fontSize: Dimensions.getFontSize(28)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            CustomDropdown(
                                label: "Currency",
                                hintText: "Select Currency",
                                items: Currencies.getCurrencyList(),
                                selectedValue: controller.selectedCurrency,
                                onChanged: (Currency? currency) {
                                  controller.setCurrency(currency!);
                                },
                                itemLabel: (Currency item) {
                                  return "${item.name} (${item.code})";
                                }),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            PrimaryButton(
                                title: "Update Currency",
                                onPressed: () async {
                                  await controller.updateCurrency();
                                })
                          ],
                        ),
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
