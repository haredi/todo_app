import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangProvider extends ChangeNotifier{
  String currentLang='en';

  void updateLang(String newLang){
    if(currentLang==newLang)return;
    currentLang=newLang;
    saveLang(newLang);
    notifyListeners();
  }
  bool isEnglish(){
    return currentLang=='en';
  }

  void saveLang(String lang)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(lang=='en'){
      prefs.setString('lang', 'en');
    }else{
      prefs.setString('lang', 'ar');
    }
  }

  void getLang()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang=prefs.getString('lang')??'en';
    if(lang=='en'){
      currentLang='en';
    }else{
      currentLang='ar';
    }
    notifyListeners();
  }
}