import 'package:flutter/material.dart';
import 'package:listen_books/page/history_page.dart';
import 'package:listen_books/widget/search_bar.dart';

class IndexPage extends StatefulWidget {
  final String _title;

  const IndexPage(this._title, {super.key});

  @override
  State<StatefulWidget> createState() => IndexPageState();

  add(HistoryPage historyPage) {}

}


const List<String> types = [
  "全部",
  "流行",
  "华语",
  "民谣",
  "摇滚",
  "清新",
  "浪漫",
  "古风",
  "影视原声",
  "欧美",
  "儿童",
  "电子",
  "校园",
  "放松"
];

class IndexPageState extends State<IndexPage>
  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin  {
  late TabController _tabController;

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
      indicatorColor: Color.fromARGB(255, 225, 235, 209),
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.only(right: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            bottom: createTabBar(),
            title: const SearchBarWidget(),
          ),
          body: TabBarView(
            controller: _tabController,
            children: types.map((item) {
              return Center(child: Text("${item}"));
            }).toList(),
          ),
        )
    );
  }
}

