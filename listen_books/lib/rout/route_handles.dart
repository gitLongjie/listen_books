
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/page/daily_songs_page.dart';
import 'package:listen_books/page/index_page.dart';
import 'package:listen_books/page/play_page.dart';
import 'package:listen_books/page/song_list_page.dart';
import 'package:listen_books/page/splash_page.dart';

var splashHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const SplashPage();
});

var homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const IndexPage('');
});

var dailySongsHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<Object>> params) {
    return const DailySongsPage();
});

var listSongsHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<Object>> params) {
    String id= params['id']![0].toString();
    String name = params['name']![0].toString();
    String artist = params['artist']![0].toString();
    return SongListPage(id: id, name:name, artist:artist);
  }
);

var playSongsHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<Object>> params) {
  return const PlayPage();
});
