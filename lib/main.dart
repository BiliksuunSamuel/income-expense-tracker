import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/routes/app.routes.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';
import 'package:ie_montrac/theme/app.theme.dart';
import 'package:ie_montrac/utils/dimensions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    return GetMaterialApp(
        title: "IE Montrac",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.routes,
        home: const WelcomeScreen());
  }
}
