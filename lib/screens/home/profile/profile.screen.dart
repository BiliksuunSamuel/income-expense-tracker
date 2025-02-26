import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/bottom-sheet/action.confirmation.bottom.sheet.dart';
import 'package:ie_montrac/components/empty.state.view.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/profile.menu.item.card.dart';
import 'package:ie_montrac/helper/resources.dart';
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

  //handle load data
  void _loadData() async {
    var controller = Get.find<AuthController>();
    await controller.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthController(repository: Get.find<Repository>()),
        builder: (authController) {
          return AppView(
            body: Stack(
              children: [
                CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: AppColors.bodyBackgroundColor,
                      automaticallyImplyLeading: false,
                      title: const SizedBox(
                        height: 0,
                      ),
                      bottom: authController.authResponse?.user == null
                          ? null
                          : PreferredSize(
                              preferredSize:
                                  Size.fromHeight(Dimensions.getHeight(80)),
                              child: ContentContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (authController
                                                .authResponse?.user?.picture !=
                                            null)
                                          Container(
                                            width: Dimensions.getWidth(60),
                                            height: Dimensions.getWidth(60),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(Dimensions
                                                        .getBorderRadius(100)),
                                                border: Border.all(
                                                    width:
                                                        Dimensions.getWidth(0),
                                                    color:
                                                        AppColors.primaryColor),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        authController
                                                            .authResponse!
                                                            .user!
                                                            .picture!),
                                                    fit: BoxFit.cover)),
                                          )
                                        else
                                          Container(
                                            width: Dimensions.getWidth(60),
                                            height: Dimensions.getWidth(60),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                      .getBorderRadius(100)),
                                              border: Border.all(
                                                  width: Dimensions.getWidth(0),
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  authController.authResponse!
                                                      .user!.firstName![0]
                                                      .toUpperCase(),
                                                  style: AppFontSize
                                                      .fontSizeMedium(
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 36)),
                                            ),
                                          ),
                                        SizedBox(
                                          width: Dimensions.getWidth(10),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Username",
                                              style: AppFontSize.fontSizeSmall(
                                                  color: AppColors.textGray),
                                            ),
                                            SizedBox(
                                              height: Dimensions.getHeight(2.5),
                                            ),
                                            Text(
                                              "${authController.authResponse?.user?.firstName} ${authController.authResponse?.user?.lastName}",
                                              style:
                                                  AppFontSize.fontSizeTitle(),
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
                        child: authController.authResponse?.user == null
                            ? Center(
                                child: EmptyStateView(
                                  message: authController.loading
                                      ? "Loading profile details,please wait!"
                                      : "Profile not found",
                                ),
                              )
                            : Container(
                                padding:
                                    EdgeInsets.all(Dimensions.getPadding(15)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.getBorderRadius(20))),
                                child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      // const ProfileMenuItemCard(
                                      //     title: "Account",
                                      //     iconPath: Resources.wallet,
                                      //     color: AppColors.primaryColor),
                                      // const ProfileMenuItemCard(
                                      //     title: "Settings",
                                      //     iconPath: Resources.settings,
                                      //     color: AppColors.primaryColor),
                                      // const ProfileMenuItemCard(
                                      //     title: "Export Data",
                                      //     iconPath: Resources.upload,
                                      //     color: AppColors.primaryColor),
                                      ProfileMenuItemCard(
                                        title: "Logout",
                                        iconPath: Resources.logout,
                                        color: AppColors.redColor,
                                        onPress: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext ctx) {
                                                return ActionConfirmationBottomSheet(
                                                  title: "Sign Out",
                                                  message:
                                                      "Do you want to sign out?",
                                                  onDecline: () {
                                                    Navigator.pop(ctx);
                                                  },
                                                  onApprove: () async {
                                                    await authController
                                                        .authSignOut();
                                                  },
                                                );
                                              });
                                        },
                                      ),
                                    ]),
                              ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: authController.loading,
                  child: const Loader(),
                )
              ],
            ),
          );
        });
  }
}
