
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {


  static saveStr(String key,String message) async {
    // ignore: avoid_print
    print("saveStr -->>> $message");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static  Future<String?> readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveModel(String key,String data)async{
    // ignore: avoid_print
    print("Shared pref -->> saveModel");
    // ignore: avoid_print
    print("saveModel -->>> $data");
    // ignore: avoid_print
    print("saveModel -->>> $key");
    final SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.setString(key, data);
  }

  static  modelRead(String key) async {
    // ignore: avoid_print
    print("modelRead -->> saveModel");
    // ignore: avoid_print
    print("modelRead -->> saveModel Key -->> $key");
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }





}