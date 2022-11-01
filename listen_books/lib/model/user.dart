
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/utils/net_utils.dart';

class User {
  String? name = "gust";
  String? password = "gust";
  String? token = '';

  User({this.name, this.password, this.token});

  User.fromJson(Map<String, dynamic> json)
      : name = json['username'],
        password = json['password'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
      'username': name,
      'password': password,
      'token': token,
  };
}

class UserModel with ChangeNotifier {
  late User _user;

  User get user => _user;

  /// 初始化 User
  void initUser() {
    if (Context.sp.containsKey('user')) {
      String? s = Context.sp.getString('user');
      _user = User.fromJson(json.decode(s!));
    }
  }

  /// 登录
  Future<User?> login(BuildContext context, String name, String pwd) async {
    User user = await NetUtils.login(context, name, pwd);
    if (user.token == null) {
     // Utils.showToast(user.msg ?? '登录失败，请检查账号密码');
      return null;
    }
    //Utils.showToast(user.msg ?? '登录成功');
    _saveUserInfo(user);
    return user;
  }

  /// 保存用户信息到 sp
  _saveUserInfo(User user) {
    _user = user;
    Context.sp.setString('user', json.encode(user.toJson()));
  }
}
