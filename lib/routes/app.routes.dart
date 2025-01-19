import 'package:get/get.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';

import '../screens/home/home.screen.dart';

class AppRoutes {
  static const String home = '/';
  static const welcomeScreen = "/welcome";
  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: welcomeScreen, page: () => const WelcomeScreen()),
  ];
}
