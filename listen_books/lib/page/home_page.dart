import 'package:flutter/material.dart';
import 'package:listen_books/page/history_page.dart';
import 'package:listen_books/widget/search_bar.dart';

class HomePage extends StatefulWidget {
  final String _title;

  const HomePage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();

  add(HistoryPage historyPage) {}

}

class HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarWidget(''),
      ),
      body: Center(
        child: Text(
          '${widget._title} 内容',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

