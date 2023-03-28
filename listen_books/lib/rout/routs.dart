import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:listen_books/page/index_page.dart';
import 'package:listen_books/rout/route_handles.dart';

class Routs {
  static String home = "/index";
  static String dailySongs = "/daily_songs";
  static String listSongs = "/list_songs";
  static String playSongs = "/play_songs";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      return const IndexPage('');
    });
    router.define(home, handler: homeHandler);
    router.define(dailySongs, handler: dailySongsHandler);
    router.define(listSongs, handler: listSongsHandler);
    router.define(playSongs, handler: playSongsHandler);
  }
}
