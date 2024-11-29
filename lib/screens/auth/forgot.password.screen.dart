import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.input.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                        title: "Forgot Password",
                      ),
                    ),
                    SliverFillRemaining(
                      child: ContentContainer(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Don't worry. Enter your email and we'll send you a link to reset your password",
                                style: AppFontSize.fontSizeTitle(
                                        fontSize: Dimensions.getFontSize(26),
                                        fontWeight: FontWeight.w600)
                                    .copyWith(
                                        wordSpacing: 0.25,
                                        letterSpacing: 0,
                                        height: Dimensions.getHeight(1.15)),
                              ),
                              SizedBox(
                                height: Dimensions.getHeight(20),
                              ),
                              CustomInput(
                                hintText: "Email Address",
                                controller: controller.emailController,
                              ),
                              SizedBox(
                                height: Dimensions.getHeight(20),
                              ),
                              PrimaryButton(
                                title: "Continue",
                                disabled: controller.loading,
                                onPressed: () async {
                                  await controller.forgotPassword();
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
