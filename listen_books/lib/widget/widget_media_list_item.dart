import 'package:flutter/material.dart';


class WidgetMediaListItemPage extends StatelessWidget {
  const WidgetMediaListItemPage({super.key});

  List<Widget> _getAllSonds() {
    List listData = [{
      "title":"标题内容1",
      "author":"作者名称1",
      "imageUrl": "http://pic.qqtn.com/up/2020-1/2020011418121854630.jpg"
    },{
      "title":"标题内容2",
      "author":"作者名称2",
      "imageUrl": "http://pic.qqtn.com/up/2020-1/2020011418121854630.jpg"
    },{
      "title":"标题内容3",
      "author":"作者名称3",
      "imageUrl": "http://pic.qqtn.com/up/2020-1/2020011418121854630.jpg"
    },{
      "title":"标题内容4",
      "author":"作者名称4",
      "imageUrl": "http://pic.qqtn.com/up/2020-1/2020011418121854630.jpg"
    }];

    var tempList = listData.map((v){
      return ListTile(
        leading: Image.network(v['imageUrl']),
        title: Text(v['title']),
        subtitle: Text(v['author']),
      );
    });
    return tempList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: this._getAllSonds(),
      ),
    );
  }
}

