import 'package:get/get.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';

import '../screens/home/home.screen.dart';

class AppRoutes {
  static const String home = '/';
  static const constituencies = "/constituencies";
  static const pollingAgents = "/polling-agents";
  static const profile = "/profile";
  static const users = "/users";
  static const pollingStations = "/polling-stations";
  static const userCreate = "/user-create";
  static const constituencyCreate = "/constituency-create";
  static const pollingStationCreate = "/polling-station-create";
  static const electionCreate = "/election-create";
  static const electionDetails = "/election-details";
  static const welcomeScreen = "/welcome";
  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: welcomeScreen, page: () => const WelcomeScreen()),
  ];
}
