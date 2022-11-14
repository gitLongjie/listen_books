import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/model/song.dart';
import 'package:listen_books/utils/navigator_util.dart';
import 'package:listen_books/widget/common_text_style.dart';
import 'package:listen_books/widget/h_empty_view.dart';
import 'package:listen_books/widget/widget_round_img.dart';

import 'package:provider/provider.dart';

/// 所有页面下面的播放条
class PlayWidget extends StatelessWidget {
  const PlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer<PlaySongsModel>(builder: (context, model, child) {
        Widget child;

        if (model.allSongs.isEmpty) {
          child = const Text('暂无正在播放的歌曲');
        } else {
          Song curSong = model.curSong;
          child = GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              NavigatorUtil.goPlaySongsPage(context);
            },
            child: Row(
              children: <Widget>[
                RoundImgWidget(curSong.metaData!.album_art, 80, fit: BoxFit.fill),
                const HEmptyView(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(curSong.metaData!.title, style: commonTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis,),
                      Text(curSong.metaData!.artist, style: common13TextStyle,),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    if(model.curState == null){
                      model.play();
                    }else {
                      model.togglePlay();
                    }
                  },
                  child: Image.asset(
                    model.curState == PlayerState.playing
                        ? 'assets/pause.png'
                        : 'assets/play.png',
                    width: ScreenUtil().setWidth(50),
                  ),
                ),
                const HEmptyView(15),
                GestureDetector(
                  onTap: (){},
                  child: Image.asset(
                    'assets/list.png',
                    width: ScreenUtil().setWidth(50),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          width: Context.screenWidth,
          height: ScreenUtil().setWidth(110) + Context.bottomBarHeight,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[200]!)),
              color: Colors.white),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          child: Container(
            width: Context.screenWidth,
            height: ScreenUtil().setWidth(110),
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            alignment: Alignment.center,
            child: child,
          ),
        );
      }),
    );
  }
}
