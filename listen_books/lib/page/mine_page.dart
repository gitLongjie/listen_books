import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  final String _title;

  const MinePage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => MinePageState();

}

class MinePageState extends State<MinePage> {
  
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
