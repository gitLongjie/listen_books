import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  final String _title;

  const FavoritePage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  
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
