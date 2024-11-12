import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/app.header.title.dart';
import 'package:ie_montrac/components/custom.input.dart';
import 'package:ie_montrac/components/google.account.auth.button.dart';
import 'package:ie_montrac/components/link.button.dart';
import 'package:ie_montrac/components/primary.button.dart';
import 'package:ie_montrac/screens/auth/login.screen.dart';
import 'package:ie_montrac/screens/auth/otp.verify.screen.dart';
import 'package:ie_montrac/theme/app.colors.dart';
import 'package:ie_montrac/theme/app.font.size.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:ie_montrac/views/app.view.dart';
import 'package:ie_montrac/views/content.container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                automaticallyImplyLeading: false,
                title: const AppHeaderTitle(
                  title: "Sign Up",
                ),
              ),
              SliverFillRemaining(
                child: ContentContainer(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomInput(
                          hintText: "Name",
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        const CustomInput(
                          hintText: "Email",
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        CustomInput(
                          hintText: "Password",
                          obscureText: true,
                          maxLines: 1,
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey,
                                size: Dimensions.getIconSize(28),
                              )),
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1.45,
                              child: Checkbox(
                                value: false,
                                onChanged: (bool? newValue) {},
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: Dimensions.getWidth(0.15),
                                        color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.getBorderRadius(3.5))),
                                side: BorderSide(
                                    width: Dimensions.getWidth(1.25),
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.getWidth(10),
                            ),
                            Expanded(
                                child: Text.rich(
                              TextSpan(
                                  text: "By signing up, you agree to the",
                                  style: AppFontSize.fontSizeSmall(
                                      fontSize: Dimensions.getFontSize(16),
                                      fontWeight: FontWeight.w500),
                                  children: [
                                    TextSpan(
                                      text:
                                          " Terms of Service and Privacy Policy",
                                      style: AppFontSize.fontSizeSmall(
                                          fontSize: Dimensions.getFontSize(16),
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ]),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        PrimaryButton(
                          title: "Sign Up",
                          onPressed: () {
                            Get.to(() => const OtpVerifyScreen());
                          },
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        Center(
                          child: Text(
                            "Or with",
                            style: AppFontSize.fontSizeMedium(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        const GoogleAccountAuthButton(
                            title: "Sign Up with Google"),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: AppFontSize.fontSizeMedium(),
                            ),
                            SizedBox(
                              width: Dimensions.getWidth(4),
                            ),
                            LinkButton(
                              onPress: () {
                                Get.to(() => const LoginScreen());
                              },
                              title: "Login",
                            )
                          ],
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
