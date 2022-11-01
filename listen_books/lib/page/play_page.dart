import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/model/song.dart';
// import 'package:listen_books/utils/audio_controller.dart';
import 'package:listen_books/widget/lyric_page_widget.dart';
import 'package:listen_books/widget/play_page_title_widget.dart';
import 'package:listen_books/widget/v_empty_view.dart';
import 'package:listen_books/widget/widget_play_bottom_menu.dart';
import 'package:listen_books/widget/widget_round_img.dart';
import 'package:listen_books/widget/widget_song_progress.dart';
import 'package:provider/provider.dart';

class PlayPage extends StatefulWidget {

  const PlayPage({super.key});

  @override
  State<StatefulWidget> createState() => _PlayPageState();

}

class _PlayPageState extends State<PlayPage> with TickerProviderStateMixin {
  late AnimationController _controller; // 封面旋转控制器
  late AnimationController _stylusController; //唱针控制器
  late Animation<double> _stylusAnimation;
  int switchIndex = 0; //用于切换歌词

  @override
  void initState() {
    // TODO: implement setState
    super.initState();

     _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _stylusController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _stylusAnimation =
        Tween<double>(begin: -0.03, end: -0.10).animate(_stylusController);
    _controller.addStatusListener((status) {
      // 转完一圈之后继续
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });

    Provider.of<PlaySongsModel>(context, listen: false).playSong(Song(0));
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<PlaySongsModel>(
        builder: (context, model, child) {
        var curSong = model.curSong;
        if (model.curState == PlayerState.playing) {
          // 如果当前状态是在播放当中，则唱片一直旋转，
          // 并且唱针是移除状态
          // _controller.forward();
          // _stylusController.reverse();
        } else {
          // _controller.stop();
          // _stylusController.forward();
        }
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
                            children: <Widget>[
                              // Stack(
                              //   children: <Widget>[
                              //     Align(
                              //       alignment: Alignment.topCenter,
                              //       child: Container(
                              //         margin: const EdgeInsets.only(top: 150),
                              //         child: RotationTransition(
                              //           turns: _controller,
                              //           child: Stack(
                              //             alignment: Alignment.center,
                              //             children: <Widget>[
                              //               Image.asset(
                              //                 'assets/bet.png',
                              //                 width:550,
                              //               ),
                              //               const RoundImgWidget('assets/bet.png', 370, fit: BoxFit.cover),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Align(
                              //       alignment: const Alignment(0.25, -1),
                              //       child: RotationTransition(
                              //         turns: _stylusAnimation,
                              //         alignment: const Alignment(
                              //           -1 + (45 * 2) /293,
                              //           -1 + (45 * 2) / 504
                              //         ),
                              //         child: Image.asset(
                              //           'assets/bgm.png',
                              //           width: 205,
                              //           height: 352.8,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              LyricPage(model),
                            ],
                          ),
                        ),
                      ),
                      buildSongsHandle(model),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: SongProgressWidget(model),
                      ),
                      PlayBottomMenuWidget(model),
                      const VEmptyView(10),
                    ],
                  ),
                ),
            ]
          ),
          backgroundColor: Colors.transparent,
        );
      }
    );
  }

  Widget buildSongsHandle(PlaySongsModel mode) {
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