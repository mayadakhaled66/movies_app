import 'package:shared_preferences/shared_preferences.dart';

class AppSharePreferences{
  static void addListOfData (String key , String data)async{
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items =await prefs.getStringList(key);

    if(items!=null&&items.isNotEmpty){
      items.add(data);
      await prefs.setStringList(key,items);
    }else{
      await prefs.setStringList(key,[data]);
    }

  }
  static Future<List<String>> getListOfData(String key)async{
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items =await prefs.getStringList(key);

    return items??[];
  }
}