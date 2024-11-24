import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/budget.card.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/screens/home/budget.create.screen.dart';
import 'package:ie_montrac/screens/home/budget.details.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return AppView(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: AppColors.primaryColor,
                title: AppHeaderTitle(
                  title: "May",
                  titleColor: Colors.white,
                  iconColor: Colors.white,
                  leftComponent: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_left,
                        size: Dimensions.getIconSize(32),
                        color: Colors.white,
                      )),
                  rightComponent: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chevron_right,
                        size: Dimensions.getIconSize(32),
                        color: Colors.white,
                      )),
                ),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(Dimensions.getHeight(20)),
                    child: const SizedBox()),
              ),
              SliverFillRemaining(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.getBorderRadius(25)),
                    topRight: Radius.circular(Dimensions.getBorderRadius(25)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.getPadding(20)),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: 20,
                                itemBuilder: (BuildContext ctx, index) {
                                  return BudgetCard(
                                    onPress: () {
                                      Get.to(() => const BudgetDetailsScreen());
                                    },
                                  );
                                })),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        PrimaryButton(
                          title: "Create Budget",
                          onPressed: () {
                            Get.to(() => const BudgetCreateScreen());
                          },
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(15),
                        )
                      ],
                    ),
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
