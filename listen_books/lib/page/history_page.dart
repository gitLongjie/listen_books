import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  final String _title;

  const HistoryPage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => HistoryPageState();

}

class HistoryPageState extends State<HistoryPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
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
