import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/controllers/transaction.controller.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/bottom-sheet/action.confirmation.bottom.sheet.dart';
import 'package:ie_montrac/bottom-sheet/transaction.history.filter.bottom.sheet.dart';
import 'package:ie_montrac/components/active.subscription.card.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/profile.menu.item.card.dart';
import 'package:ie_montrac/helper/resources.dart';
import 'package:ie_montrac/models/category.dart';
import 'package:ie_montrac/routes/app.routes.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //init
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  //on dispose
  @override
  void dispose() {
    var transactionController = Get.find<TransactionController>();
    transactionController.resetSelectedFilters();
    super.dispose();
  }

  //handle load data
  void _loadData() async {
    Get.lazyPut(() => AuthController(repository: Get.find()));
    var controller = Get.find<AuthController>();
    await controller.getProfile();

    var transactionController = Get.find<TransactionController>();
    transactionController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TransactionController(repository: Get.find()),
        builder: (transactionController) {
          return GetBuilder(
              init: AuthController(repository: Get.find<Repository>()),
              builder: (authController) {
                return Stack(
                  children: [
                    RefreshIndicator(
                        child: AppView(
                          body: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                pinned: true,
                                backgroundColor: AppColors.bodyBackgroundColor,
                                automaticallyImplyLeading: false,
                                title: const SizedBox(
                                  height: 0,
                                ),
                                bottom: authController.authResponse?.user ==
                                        null
                                    ? null
                                    : PreferredSize(
                                        preferredSize: Size.fromHeight(
                                            Dimensions.getHeight(53)),
                                        child: ContentContainer(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (authController
                                                          .authResponse
                                                          ?.user
                                                          ?.picture !=
                                                      null)
                                                    Container(
                                                      width:
                                                          Dimensions.getWidth(
                                                              60),
                                                      height:
                                                          Dimensions.getWidth(
                                                              60),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions.getBorderRadius(
                                                                      100)),
                                                          border: Border.all(
                                                              width: Dimensions
                                                                  .getWidth(0),
                                                              color: AppColors
                                                                  .primaryColor),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  authController
                                                                      .authResponse!
                                                                      .user!
                                                                      .picture!),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    )
                                                  else
                                                    Container(
                                                      width:
                                                          Dimensions.getWidth(
                                                              60),
                                                      height:
                                                          Dimensions.getWidth(
                                                              60),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .getBorderRadius(
                                                                    100)),
                                                        border: Border.all(
                                                            width: Dimensions
                                                                .getWidth(0),
                                                            color: AppColors
                                                                .primaryColor),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            authController
                                                                .authResponse!
                                                                .user!
                                                                .firstName![0]
                                                                .toUpperCase(),
                                                            style: AppFontSize
                                                                .fontSizeMedium(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        36)),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width:
                                                        Dimensions.getWidth(10),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Username",
                                                        style: AppFontSize
                                                            .fontSizeSmall(
                                                                color: AppColors
                                                                    .textGray),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .getHeight(2.5),
                                                      ),
                                                      Text(
                                                        "${authController.authResponse?.user?.firstName} ${authController.authResponse?.user?.lastName}",
                                                        style: AppFontSize
                                                            .fontSizeTitle(),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     icon: const SvgIcon(
                                              //       path: Resources.pen,
                                              //       color: Colors.black,
                                              //     ))
                                            ],
                                          ),
                                        )),
                              ),
                              SliverFillRemaining(
                                child: ContentContainer(
                                  padding: Dimensions.getPadding(8),
                                  child: authController.authResponse?.user ==
                                          null
                                      ? Center(
                                          child: EmptyStateView(
                                            message: authController.loading
                                                ? "Loading profile details,please wait!"
                                                : "Profile not found",
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(
                                              Dimensions.getPadding(15)),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                      .getBorderRadius(20))),
                                          child: ListView(
                                              padding: EdgeInsets.zero,
                                              children: [
                                                ProfileMenuItemCard(
                                                    title: "Subscriptions",
                                                    iconPath:
                                                        Resources.subscription,
                                                    color:
                                                        AppColors.primaryColor,
                                                    onPress: () {
                                                      Get.toNamed(AppRoutes
                                                          .subscriptionsScreen);
                                                    }),
                                                ProfileMenuItemCard(
                                                    title: "Invoices",
                                                    iconPath: Resources.invoice,
                                                    color:
                                                        AppColors.primaryColor,
                                                    onPress: () {
                                                      Get.toNamed(AppRoutes
                                                          .invoicesScreen);
                                                    }),
                                                // const ProfileMenuItemCard(
                                                //     title: "Settings",
                                                //     iconPath:
                                                //         Resources.settings,
                                                //     color:
                                                //         AppColors.primaryColor),
                                                ProfileMenuItemCard(
                                                  title: "Export Data",
                                                  iconPath: Resources.upload,
                                                  color: AppColors.primaryColor,
                                                  onPress: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder:
                                                            (BuildContext btx) {
                                                          return Obx(() =>
                                                              TransactionHistoryFilterBottomSheet(
                                                                onCategoryChanged:
                                                                    (Category?
                                                                        cate) {
                                                                  transactionController
                                                                      .setSelectedCategory(
                                                                          cate);
                                                                },
                                                                startDateController:
                                                                    transactionController
                                                                        .startDateController,
                                                                endDateController:
                                                                    transactionController
                                                                        .endDateController,
                                                                selectedCategory:
                                                                    transactionController
                                                                        .selectedCategory,
                                                                categories:
                                                                    transactionController
                                                                        .categories,
                                                                transactionType:
                                                                    transactionController
                                                                        .transactionType
                                                                        .value,
                                                                onTransactionTypeChanged:
                                                                    (String
                                                                        val) {
                                                                  transactionController
                                                                      .setSelectedTransactionType(
                                                                          val);
                                                                },
                                                                resetFilter:
                                                                    () {
                                                                  Navigator.pop(
                                                                      btx);
                                                                  transactionController
                                                                      .resetSelectedFilters();
                                                                },
                                                                onApply:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      btx);
                                                                  await transactionController
                                                                      .handleExportTransactions();
                                                                },
                                                              ));
                                                        });
                                                  },
                                                ),
                                                ProfileMenuItemCard(
                                                  title: "Logout",
                                                  iconPath: Resources.logout,
                                                  color: AppColors.redColor,
                                                  onPress: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder:
                                                            (BuildContext ctx) {
                                                          return ActionConfirmationBottomSheet(
                                                            title: "Sign Out",
                                                            message:
                                                                "Do you want to sign out?",
                                                            onDecline: () {
                                                              Navigator.pop(
                                                                  ctx);
                                                            },
                                                            onApprove:
                                                                () async {
                                                              Navigator.pop(
                                                                  ctx);
                                                              await authController
                                                                  .authSignOut();
                                                            },
                                                          );
                                                        });
                                                  },
                                                ),
                                                //Show subscription card if user has subscription
                                                if (authController
                                                            .authResponse !=
                                                        null &&
                                                    authController.authResponse!
                                                            .subscription !=
                                                        null) ...[
                                                  SizedBox(
                                                    height:
                                                        Dimensions.getHeight(
                                                            20),
                                                  ),
                                                  ActiveSubscriptionCard(
                                                    subscription: authController
                                                        .authResponse!
                                                        .subscription!,
                                                    onTap: () {
                                                      Get.toNamed(
                                                          AppRoutes
                                                              .subscriptionDetailsScreen,
                                                          arguments: {
                                                            "subscription":
                                                                authController
                                                                    .authResponse!
                                                                    .subscription!
                                                                    .toJson()
                                                          });
                                                    },
                                                  )
                                                ]
                                              ]),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onRefresh: () async {
                          await authController.getProfile();
                        }),
                    Visibility(
                      visible: authController.loading ||
                          transactionController.loading,
                      child: const Loader(),
                    )
                  ],
                );
              });
        });
  }
}
