
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listen_books/utils/net_utils.dart';
// import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Context{
  // static late Router router;
  static GlobalKey<NavigatorState> key = GlobalKey();
  static late SharedPreferences sp;
  static late double screenWidth;
  static late double screenHeight;
  static late double statusBarHeight;
  static late double bottomBarHeight;
  // static GetIt getIt = GetIt.instance;

  static initSp() async{
    sp = await SharedPreferences.getInstance();
  }

  static setupLocator(){
    // getIt.registerSingleton(NavigateService());
  }

  static initUser() async {
    String? userJson = Context.sp.getString("user");
    if (userJson == null) {
      var user = await NetUtils.login(null, 'gust', 'gust');
      Context.sp.setString('user', json.encode(user.toJson()));
    }
  }

}