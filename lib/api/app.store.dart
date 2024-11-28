import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStore extends GetxService {
  Future<void> saveData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString(key);
    return data;
  }

  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
