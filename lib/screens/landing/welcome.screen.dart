import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/screens/auth/auth.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

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
    await Future.delayed(const Duration(seconds: 3), () {
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
