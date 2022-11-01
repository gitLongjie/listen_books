import 'package:flutter/material.dart';
import 'package:listen_books/model/user.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  final String _title;

  const MinePage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => _MinePageState();

}

class _MinePageState extends State<MinePage> {
  
  @override
  void initState() {
    super.initState();

     Provider.of<UserModel>(context, listen: false).login(context, 'gust', 'gust');
    // NetUtils.getLyricData(context, params: params)
  }

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
