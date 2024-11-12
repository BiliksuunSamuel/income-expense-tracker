import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/components/link.button.dart';
import 'package:ie_montrac/screens/auth/register.screen.dart';
import 'package:ie_montrac/screens/home/home.screen.dart';

import '../../components/app.header.title.dart';
import '../../components/custom.input.dart';
import '../../components/google.account.auth.button.dart';
import '../../components/primary.button.dart';
import '../../theme/app.font.size.dart';
import '../../utils/dimensions.dart';
import '../../views/app.view.dart';
import '../../views/content.container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                title: AppHeaderTitle(
                  title: "Login",
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
                        PrimaryButton(
                          title: "Login",
                          onPressed: () {
                            Get.to((() => const HomeScreen()));
                          },
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        const Center(
                          child: LinkButton(
                            title: "Forgot Password",
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        const GoogleAccountAuthButton(
                            title: "Sign In with Google"),
                        SizedBox(
                          height: Dimensions.getHeight(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account yet?",
                              style: AppFontSize.fontSizeMedium(),
                            ),
                            SizedBox(
                              width: Dimensions.getWidth(4),
                            ),
                            LinkButton(
                              onPress: () {
                                Get.to(() => const RegisterScreen());
                              },
                              title: "Sign Up",
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
