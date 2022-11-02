import 'package:flutter/material.dart';
import 'package:listen_books/utils/net_utils.dart';

/// 歌单、新碟上架等封面组件
class PlayListCoverWidget extends StatelessWidget {
  final String url;
  final int? playCount;
  final double width;
  final double? height;
  final double radius;

  const PlayListCoverWidget(this.url,
      {super.key, this.playCount, this.width = 200, this.height, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        width:width,
        height: height ?? width,
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            NetUtils.showNetImage('$url?param=200y200&compress=l', width: width, height:height ?? width, fit: BoxFit.cover),
            playCount == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 2,
                        right:5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/icon_triangle.png',
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          '$playCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
