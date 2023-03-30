import 'dart:async';
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/daily_songs.dart';
import 'package:listen_books/model/music.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/model/song.dart';
import 'package:listen_books/model/user.dart';
import 'package:listen_books/utils/navigator_util.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:listen_books/widget/widget_music_list_item.dart';
import 'package:listen_books/widget/widget_play.dart';
import 'package:listen_books/widget/widget_play_list_app_bar.dart';
import 'package:listen_books/widget/widget_sliver_future_builder.dart';
import 'package:provider/provider.dart';

class DailySongsPage extends StatefulWidget {
  const DailySongsPage({super.key});

  @override
  State<StatefulWidget> createState() => _DailySongsPageState();
}

class _DailySongsPageState extends State<DailySongsPage> {
  final double _expandedHeight = 340;
  int _count = 0;
  late DailySongsData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(80) + Context.bottomBarHeight),
            child: CustomScrollView(
              slivers: <Widget>[
                PlayListAppBarWidget(
                  backgroundImg: 'assets/bg_daily.png',
                  count: _count,
                  playOnTap: (model) {
                    playSongs(model, 0);
                  },
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                        margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                  '${DateUtil.formatDate(DateTime.now(), format: 'dd')} ',
                                  style: const TextStyle(fontSize: 30)),
                              TextSpan(
                                  text:
                                  '/ ${DateUtil.formatDate(DateTime.now(), format: 'MM')}',
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                        margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
                        child: const Text(
                          '根据你的音乐口味，为你推荐好音乐。',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  expandedHeight: _expandedHeight,
                  title: '每日推荐',
                ),
                CustomSliverFutureBuilder<DailySongsData>(
                  futureFunc: NetUtils.getAlbumSongs,
                  builder: (context, data) {
                    if (data.songs == null) {
                      setCount(0);
                    }else {
                      setCount(data.songs!.length);
                    }
                    
                    return Consumer<PlaySongsModel>(
                      builder: (context, model, child) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              this.data = data;
                              var d = data.songs![index];
                              String? userJson = Context.sp.getString("user");
                              if (null == userJson) {
                                return Container();
                              }
                              var user = User.fromJson(json.decode(userJson));
                              var picUrl = "${NetUtils.baseUrl}rest/getCoverArt?u=${user.name}&f=json&v=${NetUtils.version}";
                              picUrl += "&c=${NetUtils.clientName}&id=${d.id}";
                              return WidgetMusicListItem(
                                MusicData(
                                    mvid: 0,
                                    picUrl: picUrl,
                                    songName: '',//d.metaData!.title,
                                    artists: '', //d.metaData!.artist,
                                ),
                                    //"${ d.metaData!.artists.map((a) => a.name).toList().join('/')} - ${d.album.name}"),
                                onTap: () {
                                  playSongs(model, index);
                                },
                              );
                            },
                            childCount: data.songs!.length,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const PlayWidget(),
        ],
      ),
    );
  }

  void playSongs(PlaySongsModel model, int index) {
    model.playSongs(data.songs!, index:index);
    //   data.songs!.map((d) => Song(
    //       d.id,
    //       filepath: d.filepath,
    //       metaData: d.metaData
    //     )
    //   ).toList(),
    //   index: index,
    // );
    NavigatorUtil.goPlaySongsPage(context);
  }

  void setCount(int count) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _count = count;
        });
      }
    });
  }
}
