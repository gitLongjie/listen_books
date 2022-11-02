
import 'dart:convert';
import 'dart:io';

// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/daily_songs.dart';
import 'package:listen_books/model/lyric.dart';
import 'package:listen_books/model/user.dart';
import 'package:listen_books/widget/loading.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:http/http.dart' as http;

class NetUtils {
  // static late final Dio _dio;
  static const String baseUrl = 'http://39.107.224.142:8802';

  static void init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    // CookieJar cj = PersistCookieJar();
    // _dio = Dio(BaseOptions(baseUrl: '$baseUrl:1020', followRedirects: false))
      // ..interceptors.add(CookieManager(cj))
      // ..interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));
    
    // 海外華人可使用 nondanee/UnblockNeteaseMusic
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (uri) {
    //     var host = uri.host;
    //     if (host == 'music.163.com' ||
    //         host == 'interface.music.163.com' ||
    //         host == 'interface3.music.163.com' ||
    //         host == 'apm.music.163.com' ||
    //         host == 'apm3.music.163.com' ||
    //         host == '59.111.181.60' ||
    //         host == '223.252.199.66' ||
    //         host == '223.252.199.67' ||
    //         host == '59.111.160.195' ||
    //         host == '59.111.160.197' ||
    //         host == '59.111.181.38' ||
    //         host == '193.112.159.225' ||
    //         host == '118.24.63.156' ||
    //         host == '59.111.181.35' ||
    //         host == '39.105.63.80' ||
    //         host == '47.100.127.239' ||
    //         host == '103.126.92.133' ||
    //         host == '103.126.92.132') {
    //       return 'PROXY YOURPROXY;DIRECT';
    //     }
    //     return 'DIRECT';
    //   };
    // };
  }

  static Future<Response> _get(
    BuildContext context,
    String url, {
    Map<String, dynamic>? params,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading) Loading.showLoading(context);
    try {
      // Url.parse(context)
      return await Dio().get(url, queryParameters: params);
      // return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1, requestOptions: RequestOptions(path: '')));
      } else if (e.response != null) {
        if (e.response!.statusCode! >= 300 && e.response!.statusCode! < 400) {
          // _reLogin();
          return Future.error(Response(data: -1, requestOptions: RequestOptions(path: '')));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1, requestOptions: RequestOptions(path: '')));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static Future<Response> _post(
    BuildContext? context,
    String url, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    bool isShowLoading = true,
  }) async {
    if (isShowLoading && null != context) Loading.showLoading(context);
    try {
      // Url.parse(context)
      return await Dio().post(baseUrl + url, data: data, queryParameters: params, options: options);
      // return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1, requestOptions: RequestOptions(path: '')));
      } else if (e.response != null) {
        if (e.response!.statusCode! >= 300 && e.response!.statusCode! < 400) {
          // _reLogin();
          return Future.error(Response(data: -1, requestOptions: RequestOptions(path: '')));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1, requestOptions: RequestOptions(path: '')));
      }
    } finally {
      if (null != context) {
        Loading.hideLoading(context);
      }
    }
  }

  static Future<LyricData> getLyricData(
      BuildContext context, {
      required Map<String, dynamic> params,
    }) async {
    var response =
        await _get(context, 'http://www.yymp3.com/lrc/10/91972.js', params: params, isShowLoading: true);
    var testData = '{"sgc":true,"sfy":true,"qfy":true,"transUser": {"id":1,"status":1,"demand":0,"userid":111,"nickname": "Beyond","uptime":0},"lyricUser": {"id":1,"status":1,"demand":0,"userid":111,"nickname": "Beyond","uptime":0},"lrc":{"version":1,"lyric":"\\n[ti:海阔天空]\\n[ar:beyond]\\n[al:]\\n[by:]\\n[offset:500]\\n[00:18.84]今天我\\n[00:21.85]寒夜里看雪飘过\\n[00:25.47]怀著冷却了的心窝飘远方\\n[00:31.36]风雨里追赶\\n[00:34.69]雾里分不清影踪\\n[00:37.56]天空海阔你与我\\n[00:40.37]可会变(谁没在变)\\n[00:44.00]多少次迎著冷眼与嘲笑\\n[00:51.10]从没有放弃过心中的理想\\n[00:56.19]一刹那恍惚若有所失的感觉\\n[01:02.23]不知不觉已变淡心里爱(谁明白我)\\n[01:09.24]原谅我这一生不羁放纵爱自由\\n[01:16.16]也会怕有一天会跌倒\\n[01:22.45]背弃了理想谁人都可以\\n[01:28.66]那会怕有一天只你共我\\n[01:43.17]今天我\\n[01:46.70]寒夜里看雪飘过\\n[01:49.65]怀著冷却了的心窝飘远方\\n[01:55.64]风雨里追赶\\n[01:58.74]雾里分不清影踪\\n[02:01.79]天空海阔你与我\\n[02:04.66]可会变(谁没在变)\\n[02:08.60]原谅我这一生不羁放纵爱自由\\n[02:14.69]也会怕有一天会跌倒\\n[02:21.85]背弃了理想谁人都可以\\n[02:28.03]那会怕有一天只你共我\\n[03:08.35]仍然自由自我永远高唱我歌\\n[03:17.88]走遍千里\\n[03:20.60]原谅我这一生不羁放纵爱自由\\n[03:27.32]也会怕有一天会跌倒\\n[03:33.87]背弃了理想谁人都可以\\n[03:40.12]那会怕有一天只你共我\\n[03:46.13]背弃了理想谁人都可以\\n[03:52.18]那会怕有一天只你共我\\n[03:56.95]ohyeah\\n[04:03.11]ohyeah\\n[04:07.98]oh......\\n[04:15.67]oh......"},"klyric":{"version":1,"lyric":""},"tlyric":{"version":1,"lyric":""},"code":0}';
    var jsonDat = jsonDecode(testData);
    return LyricData.fromJson(jsonDat);
  }

  static Widget showNetImage(String url,
      {double? width, double? height, BoxFit? fit}) {
    return Image(
      image: NetworkImage(url),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static login(BuildContext? context, String name, String pwd) async {
    Map<String,dynamic> map = {};
    map['username']=name;
    map['password']=pwd;
    var response = await _post(context, '/api/v1/auth/login', data: map, isShowLoading: false);

    return User.fromJson(response.data);
  }

  /// 每日推荐歌曲
  static Future<DailySongsData> getDailySongsData(BuildContext context) async {
    String? s = Context.sp.getString('user');
    if (s == null) {
      return DailySongsData(songs: []);
    }
    User user = User.fromJson(json.decode(s));
    Map<String,dynamic> map = {};
    map['playlistname']="day_30";
    String? token = user.token;
    var response = await _post(
      context,
      '/api/v1/playlist/load',
      data: map,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      })
    );
    return DailySongsData.fromJson(response.data);
  }
}
