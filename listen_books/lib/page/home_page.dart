
import 'package:flutter/material.dart';
import 'package:listen_books/page/favorite_page.dart';
import 'package:listen_books/page/history_page.dart';
import 'package:listen_books/page/index_page.dart';
import 'package:listen_books/page/mine_page.dart';
import 'package:listen_books/page/play_page.dart';
import 'package:listen_books/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _bottomNavPages = []; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _bottomNavPages
      ..add(const IndexPage('音乐'))
      ..add(const HistoryPage('听书'))
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
                Icons.music_video,
                color: Colors.white,
              ),
              onPressed:() => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(
                Icons.play_lesson,
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
        onPressed:() {NavigatorUtil.push(context, const PlayPage());},
        child: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
