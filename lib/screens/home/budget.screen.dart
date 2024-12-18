import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/budget.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/budget.card.dart';
import 'package:ie_montrac/components/loader.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(0);
    });
  }

  //handle load data
  void _loadData(int pageIndex) async {
    var controller = Get.find<BudgetController>();
    await controller.filterBudgets(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BudgetController(repository: Get.find()),
        builder: (controller) {
          return RefreshIndicator(
              onRefresh: () async {
                _loadData(0);
              },
              child: AppView(
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
                              preferredSize:
                                  Size.fromHeight(Dimensions.getHeight(20)),
                              child: const SizedBox()),
                        ),
                        SliverFillRemaining(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.getBorderRadius(25)),
                              topRight: Radius.circular(
                                  Dimensions.getBorderRadius(25)),
                            ),
                            child: Container(
                              padding:
                                  EdgeInsets.all(Dimensions.getPadding(20)),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: controller.budgets.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            var item =
                                                controller.budgets[index];
                                            return BudgetCard(
                                              budget: item,
                                              currency: controller.authResponse
                                                      ?.user?.currency ??
                                                  "",
                                              onPress: () {
                                                Get.to(() =>
                                                    const BudgetDetailsScreen());
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
                    ),
                    Visibility(
                      visible: controller.loading,
                      child: const Loader(),
                    )
                  ],
                ),
              ));
        });
  }
}
