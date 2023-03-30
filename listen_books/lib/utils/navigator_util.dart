import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/page/home_page.dart';
import 'package:listen_books/rout/routs.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder? transitionBuilder}
  ) {
    Context.router.navigateTo(context, path,
      replace: replace,
      clearStack: clearStack,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      transition: TransitionType.material);
  }

  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  static void pushFade(BuildContext context, Widget page) {
    Navigator.of(context).push(CustomRouteFade(page));
  }

  static void goHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const HomePage(title: 'Flutter Demo Home Page'))));
  }

  /// 每日推荐歌曲
  static void goDailySongsPage(BuildContext context) {
    _navigateTo(context, Routs.dailySongs);
  }

  /// 歌单列表
  static void goAlbumSongListPage(BuildContext context, param) {
    // ignore: prefer_interpolation_to_compose_strings
    _navigateTo(context, '${Routs.listSongs}?'+param);
  }

   /// 播放歌曲页面
  static void goPlaySongsPage(BuildContext context) {
    _navigateTo(context, Routs.playSongs);
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