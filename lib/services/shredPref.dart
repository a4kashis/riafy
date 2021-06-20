import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  set({ String key,  String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  checkKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.containsKey(key);
    print(value.runtimeType);
    return value;
  }

  get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  getAllKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
