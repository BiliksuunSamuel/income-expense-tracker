import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.white,
    textColor: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AuthController(repository: Get.find()),
        builder: (controller) {
          return AppView(
            backgroundColor: AppColors.primaryDark,
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: AppColors.primaryDark,
                    ),
                    SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            controller.pinCodeInputController.text,
                            style: AppFontSize.fontSizeMedium(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.getFontSize(26)),
                          ),
                          SizedBox(
                            height: Dimensions.getHeight(20),
                          ),
                          CustomKeyBoard(
                            controller: controller.pinCodeInputController,
                            pinTheme: pinTheme,
                            specialKey: Icon(
                              Icons.check,
                              key: const Key('enterKey'),
                              color: pinTheme.keysColor,
                              size: Dimensions.getIconSize(24),
                            ),
                            specialKeyOnTap: () {
                              if (kDebugMode) {
                                print(
                                    'submit pressed: ${controller.pinCodeInputController.text}');
                              }
                            },
                            maxLength: 4,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
