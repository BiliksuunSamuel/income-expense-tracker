import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/controllers/auth.controller.dart';
import 'package:ie_montrac/api/repositories/repository.dart';
import 'package:ie_montrac/components/link.button.dart';
import 'package:ie_montrac/components/loader.dart';
import 'package:ie_montrac/screens/auth/register.screen.dart';

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
                              CustomInput(
                                hintText: "Email",
                                controller: controller.emailController,
                              ),
                              SizedBox(
                                height: Dimensions.getHeight(20),
                              ),
                              CustomInput(
                                hintText: "Password",
                                obscureText: !controller.showPassword,
                                maxLines: 1,
                                controller: controller.passwordController,
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
                                title: "Login",
                                disabled: controller.loading,
                                onPressed: () async {
                                  await controller.signInWithEmail();
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
                              GoogleAccountAuthButton(
                                title: "Sign In with Google",
                                onPress: () async {
                                  await controller.googleAuth();
                                },
                              ),
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
                ),
                Visibility(visible: controller.loading, child: const Loader())
              ],
            ),
          );
        });
  }
}
