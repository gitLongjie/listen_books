import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/user.dart';

class DioUtil {
  final Dio api = Dio();
  final CookieJar _cookieJar = CookieJar();
  String? accessToken;

  DioUtil() {
    api.interceptors.add(CookieManager(_cookieJar));
    api.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('http')) {
        options.path = 'http://39.107.224.142:8802${options.path}';
        // x-access-token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImJyaWdlIiwiaWF0IjoxNjY3MzAxNjUyfQ.tIYLGrUN1XUmeNv52RpWEfdkRCGctw0feBzNgkieh_I; Path=/; Expires=Mon, 01 Nov 2027 16:24:42 GMT;
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      if ((error.response?.statusCode == 401 &&
        error.response?.data['error'] == "Authentication Error")) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      }
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    String username = 'gust';
    String password = 'gust';
    String? userJson = Context.sp.getString("user");
    if (null != userJson) {
      User user = User.fromJson(json.decode(userJson));
      username = user.name ?? username;
      password = user.password ?? password;
    }

    final response = await api
        .post('/api/v1/auth/login', data: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      accessToken = response.data["token"];
      return true;
    } else {
      // refresh token is wrong
      accessToken = null;
      return false;
    }
  }
}