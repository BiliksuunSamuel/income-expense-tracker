import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/screens/auth/auth.screen.dart';
import 'package:ie_montrac/screens/auth/otp.verify.screen.dart';
import 'package:ie_montrac/screens/home/home.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

import '../home/profile/currency.update.screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleChecks();
    });
    super.initState();
  }

  //
  void _handleChecks() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      var repository = Get.find<Repository>();
      var authUser = await repository.getAuthUser();
      if (authUser != null) {
        if (authUser.user!.authenticated) {
          if (authUser.user!.currency == null) {
            return Get.to(() => const CurrencyUpdateScreen());
          }
          return Get.to(() => const HomeScreen());
        }
        Get.to(() => const OtpVerifyScreen());
      }
      Get.to(() => const AuthScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppView(
      backgroundColor: AppColors.primaryColor,
      body: ContentContainer(
        child: Center(
          child: Text(
            "montra",
            style: AppFontSize.fontSizeTitle(
                fontSize: Dimensions.getFontSize(56),
                fontWeight: FontWeight.w700,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
