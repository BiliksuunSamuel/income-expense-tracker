import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../api/controllers/auth.controller.dart';
import '../../api/repositories/repository.dart';
import '../../components/custom.input.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthController(repository: Get.find<Repository>()),
        builder: (controller) {
          return AppView(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      title: AppHeaderTitle(
                        title: "Reset Password",
                      ),
                    ),
                    SliverFillRemaining(
                      child: ContentContainer(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Dimensions.getHeight(20),
                              ),
                              CustomInput(
                                hintText: "New Password",
                                obscureText: !controller.showPassword,
                                controller: controller.passwordController,
                                maxLines: 1,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.setPasswordVisibility(
                                          !controller.showPassword);
                                    },
                                    icon: Icon(
                                      controller.showPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                      size: Dimensions.getIconSize(28),
                                    )),
                              ),
                              SizedBox(
                                height: Dimensions.getHeight(20),
                              ),
                              CustomInput(
                                hintText: "Retype new password",
                                obscureText: !controller.showPassword,
                                controller:
                                    controller.confirmPasswordController,
                                maxLines: 1,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.setPasswordVisibility(
                                          !controller.showPassword);
                                    },
                                    icon: Icon(
                                      controller.showPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                      size: Dimensions.getIconSize(28),
                                    )),
                              ),
                              SizedBox(
                                height: Dimensions.getHeight(20),
                              ),
                              PrimaryButton(
                                title: "Continue",
                                disabled: controller.loading,
                                onPressed: () async {
                                  await controller.resetPassword();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(visible: controller.loading, child: const Loader())
              ],
            ),
          );
        });
  }
}
