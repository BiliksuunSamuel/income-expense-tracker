import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/budget.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/budget.card.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/constants/app.options.dart';
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
  final ScrollController _scrollController = ScrollController();
  int _statusFilterIndex = 0;
  //
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData(0);
      _scrollController.addListener(_onScroll);
    });
  }

  //handle load data
  void _loadData(int pageIndex) async {
    var controller = Get.find<BudgetController>();
    await controller.filterBudgets(pageIndex);
  }

  void _onScroll() async {
    // Check if the scroll position has reached the bottom
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      var controller = Get.find<BudgetController>();
      var page = controller.page;
      var hasMore =
          controller.pageSize * controller.page < controller.totalCount;
      if (!hasMore) return;
      await controller.filterBudgets(page);
    }
  }

  //listen to _statusFilterIndex change

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BudgetController(repository: Get.find()),
        builder: (controller) {
          return RefreshIndicator(
              child: AppView(
                backgroundColor: AppColors.primaryColor,
                body: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: true,
                          backgroundColor: AppColors.primaryColor,
                          title: AppHeaderTitle(
                            title: controller.statusFilter.value,
                            titleColor: Colors.white,
                            iconColor: Colors.white,
                            leftComponent: IconButton(
                                onPressed: () async {
                                  if (_statusFilterIndex == 0) {
                                    setState(() {
                                      _statusFilterIndex = 2;
                                    });
                                    controller.setStatusFilter(
                                        AppOptions.budgetStatusFilters[2]);
                                    await controller.filterBudgets(0);
                                    return;
                                  }
                                  if (_statusFilterIndex == 2) {
                                    setState(() {
                                      _statusFilterIndex = 1;
                                    });
                                    controller.setStatusFilter(
                                        AppOptions.budgetStatusFilters[1]);
                                    await controller.filterBudgets(0);
                                    return;
                                  }
                                  if (_statusFilterIndex == 1) {
                                    setState(() {
                                      _statusFilterIndex = 0;
                                    });
                                    controller.setStatusFilter(
                                        AppOptions.budgetStatusFilters[0]);
                                    await controller.filterBudgets(0);
                                    return;
                                  }
                                },
                                icon: Icon(
                                  Icons.chevron_left,
                                  size: Dimensions.getIconSize(32),
                                  color: Colors.white,
                                )),
                            rightComponent: IconButton(
                                onPressed: () async {
                                  if (_statusFilterIndex == 0) {
                                    setState(() {
                                      _statusFilterIndex = 1;
                                    });
                                    controller.setStatusFilter(
                                        AppOptions.budgetStatusFilters[1]);
                                    await controller.filterBudgets(0);
                                    return;
                                  }
                                  if (_statusFilterIndex == 1) {
                                    setState(() {
                                      _statusFilterIndex = 2;
                                    });
                                    controller.setStatusFilter(
                                        AppOptions.budgetStatusFilters[2]);
                                    await controller.filterBudgets(0);
                                    return;
                                  }

                                  if (_statusFilterIndex == 2) {
                                    setState(() {
                                      _statusFilterIndex = 0;
                                    });
                                    controller.setStatusFilter(
                                        AppOptions.budgetStatusFilters[0]);
                                    await controller.filterBudgets(0);
                                    return;
                                  }
                                },
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
                                      child: controller.budgets.isEmpty
                                          ? const Center(
                                              child: EmptyStateView(
                                                message:
                                                    "You current have not budget plans",
                                              ),
                                            )
                                          : ListView.builder(
                                              controller: _scrollController,
                                              padding: EdgeInsets.zero,
                                              itemCount:
                                                  controller.budgets.length,
                                              itemBuilder:
                                                  (BuildContext ctx, index) {
                                                var item =
                                                    controller.budgets[index];
                                                return BudgetCard(
                                                  budget: item,
                                                  currency: controller
                                                          .authResponse
                                                          ?.user
                                                          ?.currency ??
                                                      "",
                                                  onPress: () {
                                                    Get.to(
                                                        () =>
                                                            const BudgetDetailsScreen(),
                                                        arguments: {
                                                          "id": item.id
                                                        });
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
              ),
              onRefresh: () async {
                _loadData(0);
              });
        });
  }
}
