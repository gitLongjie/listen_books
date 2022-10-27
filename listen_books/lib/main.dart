import 'package:flutter/material.dart';
import 'package:listen_books/page/home_page.dart';
import 'package:listen_books/page/history_page.dart';
import 'package:listen_books/page/favorite_page.dart';
import 'package:listen_books/page/mine_page.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Widget> _bottomNavPages = []; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _bottomNavPages
      ..add(const HomePage('首页'))
      ..add(const HistoryPage('历史'))
      ..add(const FavoritePage('收藏'))
      ..add(const MinePage('我的')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavPages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              onPressed:() => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
              onPressed:() => _onItemTapped(1),
            ),
            const SizedBox(),
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed:() => _onItemTapped(2),
            ),IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed:() => _onItemTapped(3),
            ),
          ],          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {},
        child: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
