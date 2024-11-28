import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/constants/keys.dart';
import 'package:ie_montrac/dtos/email.signin.request.dart';
import 'package:ie_montrac/dtos/email.signup.request.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/screens/home/home.screen.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';

import '../../models/auth.response.dart';
import '../repositories/repository.dart';

class AuthController extends GetxController {
  final Repository repository;
  AuthController({required this.repository});

  //variables;
  bool loading = false;
  AuthResponse? authResponse;
  bool showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  //change password visibility
  void setPasswordVisibility(bool newValue) {
    showPassword = newValue;
    update();
  }

  //sign in with email
  Future<void> signInWithEmail() async {
    try {
      loading = true;
      var data = EmailSignInRequest(
              email: emailController.text, password: passwordController.text)
          .toJson();
      var request = HttpRequestDto("/api/authentication/login", data: data);
      var res = await repository.postAsync(request);
      if (res.code != 200) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      authResponse = AuthResponse.fromJson(res.data);
      await repository.saveAuthUser(authResponse!);
      loading = false;
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //sing up with email
  Future<void> signUpWithEmail() async {
    try {
      loading = true;
      update();
      var data = EmailSignUpRequest(
              email: emailController.text,
              password: passwordController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text)
          .toJson();
      var request = HttpRequestDto("/api/authentication/register", data: data);
      var res = await repository.postAsync(request);
      if (res.code != 200) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      authResponse = AuthResponse.fromJson(res.data);
      await repository.saveAuthUser(authResponse!);
      loading = false;
      update();
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //handle logout
  Future<void> authSignOut() async {
    try {
      loading = true;
      update();
      var authUser = await repository.getAuthUser();
      if (authUser == null) {
        loading = false;
        update();
        return Get.to(() => const WelcomeScreen());
      }
      var request = HttpRequestDto(
        "/api/authentication/logout",
        token: authUser.token,
      );
      await repository.patchAsync(request);
      if (authUser.user != null && authUser.user!.isGoogleAuth!) {
        await GoogleSignIn().disconnect();
      }
      await repository.removeFromLocalStorage(Keys.User);
      loading = false;
      update();
      Get.to(() => const WelcomeScreen());
    } catch (_) {
      loading = false;
      update();
      await repository.removeFromLocalStorage(Keys.User);
      Get.to(() => const WelcomeScreen());
    }
  }

  //handle google sign in/sign up
  Future<void> googleAuth() async {
    try {
      loading = true;
      update();
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      var googleAuth = await googleUser!.authentication;
      var httpRequest = HttpRequestDto("/api/authentication/google-auth",
          data: {"accessToken": googleAuth.accessToken});
      var response = await repository.postAsync(httpRequest);
      if (response.code != 200) {
        loading = false;
        return Get.dialog(ResponseModal(message: response.message));
      }
      var authInfo = AuthResponse.fromJson(response.data);
      authResponse = authInfo;
      await repository.saveAuthUser(authInfo);
      loading = false;
      update();
      Get.to(() => const HomeScreen());
    } catch (_) {
      loading = false;
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
      update();
    }
  }

  @override
  void onInit() async {
    var authUser = await repository.getAuthUser();
    authResponse = authUser;
    update();
    super.onInit();
  }
}
