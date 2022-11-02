import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/play_songs_model.dart';
import 'package:listen_books/page/home_page.dart';
import 'package:listen_books/utils/navigator_util.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:listen_books/utils/screen_utils.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Tween _scaleTween;
  late CurvedAnimation _logoAnimation;

  @override
  void initState() {
    super.initState();
    _scaleTween = Tween(begin: 0, end: 1);
    _logoController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..drive(_scaleTween);
    Future.delayed(const Duration(milliseconds: 500), () {
      _logoController.forward();
    });
    _logoAnimation =
        CurvedAnimation(parent: _logoController, curve: Curves.easeOutQuart);

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          goPage();
        });
      }
    });
  }

  void goPage() async{
    await Context.initSp();
    await Context.initUser();
    // ignore: use_build_context_synchronously
    NavigatorUtil.goHomePage(context);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const HomePage(title: 'Flutter Demo Home Page')),
    // );
    // UserModel userModel = Provider.of<UserModel>(context);
    // userModel.initUser();
    // PlaySongsModel playSongsModel = Provider.of<PlaySongsModel>(context);
    // 判断是否有保存的歌曲列表
    // if(Context.sp.containsKey('playing_songs')){
    //   List<String>? songs = Context.sp.getStringList('playing_songs');
    //   // playSongsModel.addSongs(songs!.map((s) => Song.fromJson(FluroConvertUtils.string2map(s))).toList());
    //   int? index = Context.sp.getInt('playing_index');
    //   // playSongsModel.curIndex = index!;
    // }
    // if (userModel.user != null) {
    //   await NetUtils.refreshLogin(context).then((value){
    //     if(value.data != -1){
    //       NavigatorUtil.goHomePage(context);
    //     }
    //   });
    //   Provider.of<PlayListModel>(context).user = userModel.user;
    // } else
    //   NavigatorUtil.goLoginPage(context);
  }

  @override
  Widget build(BuildContext context) {
    NetUtils.init();
     ScreenUtils.init(750, 1334);
    final size = MediaQuery.of(context).size;
    Context.screenWidth = size.width;
    Context.screenHeight = size.height;
    Context.statusBarHeight = MediaQuery.of(context).padding.top;
    Context.bottomBarHeight = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ScaleTransition(
          scale: _logoAnimation,
          child: Hero(
            tag: 'logo',
            child: Image.asset('assets/icon_logo.png'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoController.dispose();
  }
}
