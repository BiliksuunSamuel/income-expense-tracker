class AppConfiguration {
  static const String appName = "Income Expense Tracker";
  static const String appVersion = "1.0.0";
  static const String appIcon = "assets/icons/icon.png";

  //
  static const bool prod = true;
  static const String prodUrl = "https://plankton-app-jznh9.ondigitalocean.app";
  static const String localUrl = "http://192.168.0.180:3303";

  static String get baseUrl => prod ? prodUrl : localUrl;
}
