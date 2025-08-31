class AppConfiguration {
  static const String appName = "Income Expense Tracker";
  static const String appVersion = "1.0.0";
  static const String appIcon = "assets/icons/icon.png";

  //
  static const bool prod = true;
  static const String prodUrl =
      "https://income-expense-tracker-api.onrender.com";
  static const String localUrl = "http://localhost:3303";

  static String get baseUrl => prod ? prodUrl : localUrl;
}
