import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/utils/screen_utils.dart';
import 'package:listen_books/widget/common_text_style.dart';
import 'package:listen_books/widget/lyric_page_widget.dart';
import 'package:listen_books/widget/play_page_title_widget.dart';
import 'package:listen_books/widget/v_empty_view.dart';
import 'package:listen_books/widget/widget_future_builder.dart';
import 'package:listen_books/widget/widget_play_bottom_menu.dart';
import 'package:listen_books/widget/widget_song_progress.dart';

class PlayPage extends StatefulWidget {
  final String _title;

  const PlayPage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => _PlayPageState();

}

class _PlayPageState extends State<PlayPage> {
  int switchIndex = 0; //用于切换歌词
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/10a2d91f65223a83d6a44b038657f6ba.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 100,
                sigmaX: 100,
              ),
              child: Container(
                color: Colors.black38,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: const PlayPageAppBarWidget(
              title: '海阔天空',
              artist:'Beyond',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: kToolbarHeight,
            ),
            child: Column(
              children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        setState(() {
                          if(switchIndex == 0){
                            switchIndex = 1;
                          }else{
                            switchIndex = 0;
                          }
                        });
                      },
                      child: IndexedStack(
                        index: switchIndex,
                        children: const <Widget>[
                          LyricPage(),
                        ],
                      ),
                    ),
                  ),

                  buildSongsHandle(),
                  const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10),
                    child: SongProgressWidget(),
                  ),
                  const PlayBottomMenuWidget(),
                  const VEmptyView(10),
                ],
              ),
            ),
        ]
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget buildSongsHandle() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 243, 131, 131),
            ),
            onPressed: () {  },
          ),
          IconButton(
            tooltip: 'icon_song_download',
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () {  },
          ),
          IconButton(
            tooltip: 'bfc',
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {  },
          ),
          // Expanded(
          //   child: Align(
          //     child: Container(
          //       width: 130,
          //       height: 80,
          //       child: CustomFutureBuilder<SongCommentData>(
          //         futureFunc: NetUtils.getSongCommentData,
          //         params: {'id': model.curSong.id, 'offset': 1},
          //         loadingWidget: Image.asset(
          //           'images/icon_song_comment.png',
          //           width: ScreenUtil().setWidth(80),
          //           height: ScreenUtil().setWidth(80),
          //         ),
          //         builder: (context, data) {
          //           return GestureDetector(
          //             onTap: () {
          //              // NavigatorUtil.goCommentPage(context, data: CommentHead(model.curSong.picUrl, model.curSong.name, model.curSong.artists, data.total, model.curSong.id, CommentType.song.index));
          //             },
          //             child: Stack(
          //               alignment: Alignment.center,
          //               children: <Widget>[
          //                 Image.asset(
          //                   'images/icon_song_comment.png',
          //                   width: ScreenUtil().setWidth(80),
          //                   height: ScreenUtil().setWidth(80),
          //                 ),
          //                 Align(
          //                   alignment: Alignment.topRight,
          //                   child: Container(
          //                     margin: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
          //                     width: ScreenUtil().setWidth(58),
          //                     child: Text(
          //                       '${NumberUtils.formatNum(data.total)}',
          //                       style: common10White70TextStyle,
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          IconButton(
            tooltip: 'bfc',
            icon: const Icon(
              Icons.more,
              color: Colors.white,
            ),
            onPressed: () {  },
          ),
        ],
      ),
    );
  }

   @override
   void dispose() {
    
    super.dispose();
  }

}