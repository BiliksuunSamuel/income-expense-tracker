import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStore extends GetxService {
  //let's register share preference
  final SharedPreferences _prefs;

  AppStore({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> saveData(String key, String data) async {
    await _prefs.setString(key, data);
  }

  Future<dynamic> getData(String key) async {
    var data = await _prefs.getString(key);
    return data;
  }

  Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearData() async {
    await _prefs.clear();
  }
}
