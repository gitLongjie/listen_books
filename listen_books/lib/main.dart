import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/model/user.dart';
import 'package:listen_books/page/splash_page.dart';
import 'package:listen_books/rout/routs.dart';
import 'package:provider/provider.dart';

void main() {
  FluroRouter router = FluroRouter();
  Routs.configureRoutes(router);
  Context.router = router;
  Context.setupLocator();
  
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
      ),
      ChangeNotifierProvider<PlaySongsModel>(
        create: (_) => PlaySongsModel()..init(),
      ),
      // ChangeNotifierProvider<PlayListModel>(
      //   create: (_) => PlayListModel(),
      // ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const HomePage(title: 'Flutter Demo Home Page'),
      home: const SplashPage(),
    );
  }
}
