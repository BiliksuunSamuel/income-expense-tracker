import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ie_montrac/api/services/events.service.dart';
import 'package:ie_montrac/api/services/notification.service.dart';
import 'package:ie_montrac/components/response.modal.dart';
import 'package:ie_montrac/constants/keys.dart';
import 'package:ie_montrac/dtos/email.signin.request.dart';
import 'package:ie_montrac/dtos/email.signup.request.dart';
import 'package:ie_montrac/dtos/http.request.dto.dart';
import 'package:ie_montrac/models/currency.dart';
import 'package:ie_montrac/screens/auth/otp.verify.screen.dart';
import 'package:ie_montrac/screens/auth/reset.password.screen.dart';
import 'package:ie_montrac/screens/home/home.screen.dart';
import 'package:ie_montrac/screens/home/profile/currency.update.screen.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';

import '../../models/auth.response.dart';
import '../repositories/repository.dart';

class AuthController extends GetxController {
  NotificationServices notificationServices = NotificationServices();
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
  TextEditingController otpController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Currency? selectedCurrency;
  var pinCodeInputController = TextEditingController();

  var otpValidity = 0.obs;

  //clear pin code
  void clearPinCode() {
    pinCodeInputController.clear();
    update();
  }

  //set currency
  void setCurrency(Currency currency) {
    selectedCurrency = currency;
    update();
  }

  void setOtpValidity(int value) {
    otpValidity.value = value;
  }

  Future<void> getAuthUser() async {
    var res = await repository.getAuthUser();
    authResponse = res;
    update();
  }

  //get profile
  Future<void> getProfile() async {
    try {
      loading = true;
      update();
      await getAuthUser();
      var request = HttpRequestDto("/api/authentication/profile",
          token: authResponse?.token);
      var res = await repository.getAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      var authInfo = AuthResponse.fromJson(res.data);
      authResponse = authInfo;
      await repository.saveAuthUser(authInfo);
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

  //update currency
  Future<void> updateCurrency() async {
    try {
      loading = true;
      await repository.getAuthUser();
      update();
      var request = HttpRequestDto("/api/authentication/update-currency",
          token: authResponse?.token,
          data: {
            "code": selectedCurrency?.code,
            "name": selectedCurrency?.name
          });
      var res = await repository.patchAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        if (res.code == 401) {
          await repository.removeFromLocalStorage(Keys.User);
          return Get.offAll(() => const WelcomeScreen());
        }
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      var authInfo = AuthResponse.fromJson(res.data);
      authResponse = authInfo;
      await repository.saveAuthUser(authInfo);
      loading = false;
      update();
      Get.offAll(() => const HomeScreen());
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

//handle reset password
  Future<void> resetPassword() async {
    try {
      loading = true;
      update();
      var request = HttpRequestDto("/api/authentication/reset-password",
          data: {
            "password": passwordController.text,
            "confirmPassword": confirmPasswordController.text,
          },
          token: authResponse?.token);
      var res = await repository.patchAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      loading = false;
      passwordController.clear();
      confirmPasswordController.clear();
      var authInfo = AuthResponse.fromJson(res.data);
      await repository.saveAuthUser(authInfo);
      update();
      Get.offAll(() => const HomeScreen());
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry, an error occurred",
      ));
    }
  }

  //handle forgot password
  Future<void> forgotPassword() async {
    try {
      loading = true;
      update();
      var request = HttpRequestDto("/api/authentication/forgot-password",
          data: {"email": emailController.text});
      var res = await repository.patchAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      var authInfo = AuthResponse.fromJson(res.data);
      authResponse = authInfo;
      await repository.saveAuthUser(authInfo);
      loading = false;
      emailController.clear();
      update();
      Get.offAll(() => const OtpVerifyScreen());
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //handle verify otp
  Future<void> confirmVerificationCode() async {
    try {
      loading = true;
      update();
      var fcmToken = await notificationServices.getDeviceToken();
      var request = HttpRequestDto("/api/authentication/otp-verify",
          token: authResponse?.token,
          data: {
            "code": otpController.text,
            "fcmToken": fcmToken,
          });
      var res = await repository.patchAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      loading = false;
      var authInfo = AuthResponse.fromJson(res.data);
      authResponse = authInfo;
      await repository.saveAuthUser(authInfo);
      otpController.clear();

      update();
      if (authInfo.user!.resetPassword) {
        return Get.offAll(() => const ResetPasswordScreen());
      }

      if (authResponse?.user != null) {
        EventsService.signInEvent(
            authResponse!.user!.id!, authResponse!.user!.tokenId!);
      }
      return authResponse!.user!.currency != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const CurrencyUpdateScreen());
    } catch (_) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
    }
  }

  //handle resend verification code
  Future<void> resendVerificationCode() async {
    try {
      loading = true;
      update();
      var request = HttpRequestDto("/api/authentication/otp-resend",
          token: authResponse?.token);
      var res = await repository.postAsync(request);
      if (!res.isSuccessful) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      var resData = AuthResponse.fromJson(res.data);
      authResponse = resData;
      await repository.saveAuthUser(resData);
      final expiryTime = resData.user!.otpExpiryTime!;
      final currentTime = DateTime.now();
      final difference = expiryTime.difference(currentTime).inSeconds;
      otpValidity.value = difference > 0 ? difference : 0;
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

  //change password visibility
  void setPasswordVisibility(bool newValue) {
    showPassword = newValue;
    update();
  }

  //sign in with email
  Future<void> signInWithEmail() async {
    try {
      loading = true;
      update();
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
      emailController.clear();
      passwordController.clear();
      showPassword = false;

      if (authResponse!.user!.authenticated) {
        //updating user fcm token
        var fcmToken = await notificationServices.getDeviceToken();
        var fcmUpdateRequest = HttpRequestDto("/api/authentication/fcm-token",
            token: authResponse?.token, data: {"fcmTo;ken": fcmToken});
        await repository.patchAsync(fcmUpdateRequest);
        //end of fcm update
      }

      if (authResponse!.user!.authenticated) {
        if (authResponse?.user != null) {
          EventsService.signInEvent(
              authResponse!.user!.id!, authResponse!.user!.tokenId!);
        }
        return authResponse!.user!.currency != null
            ? Get.offAll(() => const HomeScreen())
            : Get.offAll(() => const CurrencyUpdateScreen());
      }
      final expiryTime = authResponse!.user!.otpExpiryTime!;
      final currentTime = DateTime.now();
      final difference = expiryTime.difference(currentTime).inSeconds;
      otpValidity.value = difference > 0 ? difference : 0;
      update();
      Get.offAll(() => const OtpVerifyScreen());
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
      if (res.code != 200 && res.code != 201) {
        loading = false;
        update();
        return Get.dialog(ResponseModal(
          message: res.message,
        ));
      }
      authResponse = AuthResponse.fromJson(res.data);
      await repository.saveAuthUser(authResponse!);
      loading = false;
      emailController.clear();
      firstNameController.clear();
      lastNameController.clear();
      passwordController.clear();
      showPassword = false;
      update();
      if (authResponse!.user!.authenticated) {
        if (authResponse?.user != null) {
          EventsService.signInEvent(
              authResponse!.user!.id!, authResponse!.user!.tokenId!);
        }
        return authResponse!.user!.currency != null
            ? Get.offAll(() => const HomeScreen())
            : Get.offAll(() => const CurrencyUpdateScreen());
      }
      Get.to(() => const OtpVerifyScreen());
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
        return Get.offAll(() => const WelcomeScreen());
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

      Get.offAll(() => const WelcomeScreen());
    } catch (_) {
      loading = false;
      update();
      await repository.removeFromLocalStorage(Keys.User);
      Get.offAll(() => const WelcomeScreen());
    }
  }

  //handle google sign in/sign up
  Future<void> googleAuth() async {
    try {
      loading = true;
      update();
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      var googleAuth = await googleUser!.authentication;
      var fcmToken = await notificationServices.getDeviceToken();
      var httpRequest = HttpRequestDto("/api/authentication/google-auth",
          data: {"accessToken": googleAuth.accessToken, "fcmToken": fcmToken});
      var response = await repository.postAsync(httpRequest);
      if (!response.isSuccessful) {
        loading = false;
        return Get.dialog(ResponseModal(message: response.message));
      }
      var authInfo = AuthResponse.fromJson(response.data);
      authResponse = authInfo;
      await repository.saveAuthUser(authInfo);

      loading = false;
      update();
      if (authResponse?.user != null) {
        EventsService.signInEvent(
            authResponse!.user!.id!, authResponse!.user!.tokenId!);
      }
      return authResponse!.user!.currency != null
          ? Get.offAll(() => const HomeScreen())
          : Get.offAll(() => const CurrencyUpdateScreen());
    } catch (e) {
      loading = false;
      update();
      Get.dialog(const ResponseModal(
        message: "Sorry,an error occurred",
      ));
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
