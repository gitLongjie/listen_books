import 'package:flutter/material.dart';
import 'package:listen_books/model/album.dart';
import 'package:listen_books/utils/navigator_util.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:listen_books/widget/widget_future_builder.dart';


class WidgetMediaListItemPage extends StatelessWidget {
  const WidgetMediaListItemPage({super.key});

  Widget _getAllSonds(context, index, List<Album> dirs) {
    return GestureDetector(
      onTap: () {
        String param = 'id=${dirs[index].id}&name=${dirs[index].name}&artist=${dirs[index].artist}';
        NavigatorUtil.goAlbumSongListPage(context, param);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 110,
        height: 110,
        // ignore: sort_child_properties_last
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Image.asset('assets/icon_dir_mp3.png',width: 110,height: 100,fit: BoxFit.fitWidth),
            const SizedBox(height: 10),
            Text(dirs[index].name, textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white
                )),
          ],
        ),

        //绘制圆角背景
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.deepPurple,
            border: Border.all(
                color: Colors.deepPurple,
                width: 1.0,
            )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<AlbumList>(
      futureFunc: NetUtils.getAlbum,
      builder: (context, snapshot) {
        var data = snapshot.albums;
        
        var crossAxisCount = 2;
        return  Container(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0
            ),
            itemBuilder: (context, index) {
              return _getAllSonds(context, index, data);
            }
          ),
        );
      },
    );
  }
}

