import 'package:flutter/material.dart';
import 'package:listen_books/page/home_page.dart';

class NavigatorUtil {
  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static void pushFade(BuildContext context, Widget page) {
    Navigator.of(context).push(CustomRouteFade(page));
  }

  static void goHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const HomePage(title: 'Flutter Demo Home Page'))));
  }
}

// 渐变效果
class CustomRouteFade extends PageRouteBuilder {
  final Widget widget;
  CustomRouteFade(this.widget) : super(
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (BuildContext context, Animation<double> animation1,
        Animation<double> animation2) {
      return widget;
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
        Widget child) {
      return FadeTransition(
        opacity: Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(
            parent: animation1, curve: Curves.fastOutSlowIn)),
        child: child,
      );
    }
  );
}