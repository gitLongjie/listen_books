// ignore_for_file: constant_identifier_names

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:listen_books/model/daily_songs.dart';
import 'package:listen_books/page/history_page.dart';
import 'package:listen_books/utils/navigator_util.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:listen_books/widget/h_empty_view.dart';
import 'package:listen_books/widget/search_bar.dart';
import 'package:listen_books/widget/v_empty_view.dart';
import 'package:listen_books/widget/widget_future_builder.dart';
import 'package:listen_books/widget/widget_play_list.dart';

import '../widget/widget_media_list_item.dart';

class IndexPage extends StatefulWidget {
  final String _title;

  const IndexPage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => IndexPageState();

  add(HistoryPage historyPage) {}

}

class IndexPageState extends State<IndexPage>
  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin  {
  late TabController _tabController;

  static const List<String> types = [
    "全部",
    "专辑",
    "歌手",
    "最新添加",
    "播放最多"
  ];

  static const List<Widget> type_views = [
    Center(child: WidgetMediaListItemPage()),
    Center(child: Text('Content of Tab Two')),
    Center(child: Text('Content of Tab Three')),
    Center(child: Text('Content of Tab Foure')),
    Center(child: Text('Content of Tab Five')),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //初始化controller并添加监听
    _tabController = TabController(length: types.length, vsync: this);
    _tabController.addListener(() => _onTabChanged());
  }

   void _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation?.value) {}
  }

  TabBar createTabBar()  {
    return TabBar(
      controller: _tabController,
      tabs: types.map((item) {
        return Tab(
          height: 44,
          text: item,
        );
      }).toList(),
      isScrollable: true,
      physics: const BouncingScrollPhysics(),
      indicatorColor: const Color.fromARGB(255, 225, 235, 209),
      indicatorWeight: 3,
      indicatorPadding: const EdgeInsets.only(right: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       bottom: createTabBar(),
        title: const SearchBarWidget(),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 15,
      //         ),
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: <Widget>[
      //             const VEmptyView(40),
      //             _buildHomeCategoryList(),
      //             const VEmptyView(20),
      //             const Text(
      //               '推荐歌单',
      //               style: commonTextStyle,
      //             ),
      //           ],
      //         ),
      //       ),
      //       const VEmptyView(20),
      //       _buildDay30PlayList(),
      //     ],
      //   ),
      // ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        children: type_views,
        // children: types.map((item) {
        //   return Center(child: Text("${item}"));
        // }).toList(),
      ),
    );
  }

  Widget _buildHomeCategoryList() {
    var map = {
      '每日推荐': 'assets/icon_daily.png',
      '歌单': 'assets/icon_playlist.png',
      '排行榜': 'assets/icon_rank.png',
      // '电台': 'assets/icon_radio.png',
      // '直播': 'assets/icon_look.png',
    };

    List<String> keys = map.keys.toList();
    double width = 100;

    return GridView.custom(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: keys.length,
        childAspectRatio: 1 / 1.1,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              switch (index) {
                case 0:
                  NavigatorUtil.goDailySongsPage(context);
                  break;
                case 1:
                  break;
                case 2:
                  // NavigatorUtil.goTopListPage(context);
                  break;
              }
            },
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width / 2),
                          border: Border.all(color: Colors.black12, width: 0.5),
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFFFF8174),
                              Colors.red,
                            ],
                            center: Alignment(-1.7, 0),
                            radius: 1,
                          ),
                          color: Colors.red),
                    ),
                    Image.asset(
                      map[keys[index]]!,
                      width: width,
                      height: width,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      child: keys[index] == '每日推荐'
                          ? Text(
                              DateUtil.formatDate(DateTime.now(), format: 'dd'),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          : const Text(''),
                    )
                  ],
                ),
                const VEmptyView(10),
                Text(
                  keys[index],
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          );
        },
        childCount: keys.length,
      ),
    );
  }

  Widget _buildDay30PlayList() {
    return CustomFutureBuilder<DailySongsData>(
      futureFunc: NetUtils.getAlbumSongs,
      builder: (context, snapshot) {
        var data = snapshot.songs;
        if (data == null) {
          return Container();
        }
        
        return SizedBox(
            height: 300,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const HEmptyView(30);
              },
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(150)
              ),
              itemBuilder: (context, index) {
                return PlayListWidget(
                  text: 'test', //data[index].metaData?.title,
                  picUrl: 'test', //data[index].metaData?.album_art,
                  playCount: 1,
                  maxLines: 2,
                  onTap: () {
                   // NavigatorUtil.goPlayListPage(context, data: data[index]);
                  },
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
            ));
      },
    );
  }
}

