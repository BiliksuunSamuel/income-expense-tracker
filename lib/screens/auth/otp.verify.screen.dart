import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.otp.input.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../api/repositories/repository.dart';
import '../../components/link.button.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() async {
    var repository = Get.find<Repository>();
    var controller = Get.find<AuthController>();
    var authInfo = await repository.getAuthUser();
    if (authInfo?.user != null && authInfo!.user!.otpExpiryTime != null) {
      final expiryTime = authInfo.user!.otpExpiryTime!;
      final currentTime = DateTime.now();
      final difference = expiryTime.difference(currentTime).inSeconds;
      controller.setOtpValidity(difference > 0 ? difference : 0);
    }
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (controller.otpValidity.value == 0) {
          timer.cancel();
        } else {
          controller.setOtpValidity(controller.otpValidity.value - 1);
        }
      },
    );
  }

  String get timerText {
    final start = Get.find<AuthController>().otpValidity.value;
    final minutes = (start ~/ 60).toString().padLeft(2, '0');
    final seconds = (start % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

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
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    title: AppHeaderTitle(
                      title: "Verification",
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
                            Text(
                              "Enter your Verification Code",
                              style: AppFontSize.fontSizeTitle(
                                  fontSize: Dimensions.getFontSize(36),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            CustomOtpInput(
                              controller: controller.otpController,
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            Obx(() => Text(
                                  timerText,
                                  style: AppFontSize.fontSizeMedium(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            Text.rich(
                              TextSpan(
                                  text:
                                      "We sent a verification code to your email ",
                                  style: AppFontSize.fontSizeMedium(),
                                  children: [
                                    TextSpan(
                                        text: controller
                                                .authResponse?.user?.email ??
                                            "",
                                        style: AppFontSize.fontSizeMedium(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: ". You can check your inbox.",
                                        style: AppFontSize.fontSizeMedium())
                                  ]),
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            LinkButton(
                              title: "I didn't receive the code? Send again",
                              fontWeight: FontWeight.normal,
                              onPress: () async {
                                await controller.resendVerificationCode();
                              },
                            ),
                            SizedBox(
                              height: Dimensions.getHeight(20),
                            ),
                            PrimaryButton(
                              title: "Verify",
                              onPressed: () async {
                                await controller.confirmVerificationCode();
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
      },
    );
  }
}
