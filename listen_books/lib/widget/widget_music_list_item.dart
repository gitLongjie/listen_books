import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/music.dart';
import 'package:listen_books/widget/common_text_style.dart';
import 'package:listen_books/widget/h_empty_view.dart';
import 'package:listen_books/widget/rounded_net_image.dart';
import 'package:listen_books/widget/v_empty_view.dart';

class WidgetMusicListItem extends StatelessWidget {
  final MusicData _data;
  final VoidCallback? onTap;

  const WidgetMusicListItem(this._data, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox(
        width: Context.screenWidth,
        height: ScreenUtil().setWidth(120),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ignore: unnecessary_null_comparison
            _data.index == null && _data.picUrl == null
                ? Container()
                : const HEmptyView(15),
            _data.picUrl == null
                ? Container()
                : RoundedNetImage(
                    _data.picUrl,
                    width: 100,
                    height: 100,
                    radius: 5,
                  ),
            _data.index == null
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(50),
                    child: Text(
                      _data.index.toString(),
                      style: mGrayTextStyle,
                    ),
                  ),
            _data.index == null && _data.picUrl == null
                ? Container()
                : const HEmptyView(10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _data.songName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: commonTextStyle,
                  ),
                  const VEmptyView(10),
                  Text(
                    _data.artists,
                    style: smallGrayTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: _data.mvid == 0
                  ? Container()
                  : IconButton(
                      icon: const Icon(Icons.play_circle_outline),
                      onPressed: () {},
                      color: Colors.grey,
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
