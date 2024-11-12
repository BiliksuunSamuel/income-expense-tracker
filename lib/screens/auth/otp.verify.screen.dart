import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.otp.input.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/screens/auth/forgot.password.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../../components/link.button.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
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
                        const CustomOtpInput(),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        Text(
                          "04:59",
                          style: AppFontSize.fontSizeMedium(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
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
                                    text: "biliksuun*****@gmail.com",
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
                        const LinkButton(
                          title: "I didn't receive the code? Send again",
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        PrimaryButton(
                          title: "Verify",
                          onPressed: () {
                            Get.to(() => const ForgotPasswordScreen());
                          },
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
