import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
// import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:listen_books/context.dart';
import 'package:listen_books/model/song.dart';
import 'package:listen_books/model/user.dart';
import 'package:listen_books/utils/net_utils.dart';
import 'package:provider/provider.dart';


class PlaySongsModel with ChangeNotifier{
  final AudioPlayer _audioPlayer = AudioPlayer();
  final StreamController<String> _curPositionController = StreamController<String>.broadcast();

  List<Song> _songs = [];
  int curIndex = 0;
  Duration curSongDuration = const Duration();
  PlayerState _curState = PlayerState.stopped;

  List<Song> get allSongs => _songs;
  Song get curSong => _songs[curIndex];
  Stream<String> get curPositionStream => _curPositionController.stream;
  PlayerState get curState => _curState;


  void init() {
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    // 播放状态监听
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;
      /// 先做顺序播放
      if(state == PlayerState.completed){
        nextPlay();
      }
      // 其实也只有在播放状态更新时才需要通知。
      notifyListeners();
    });
    _audioPlayer.onDurationChanged.listen((d) {
      curSongDuration = d;
    });
    // 当前播放进度监听
    _audioPlayer.onPositionChanged.listen((Duration p) {
      sinkProgress(p.inMilliseconds > curSongDuration.inMilliseconds ? curSongDuration.inMilliseconds : p.inMilliseconds);
    });
  }

  // 歌曲进度
  void sinkProgress(int m){
    _curPositionController.sink.add('$m-${curSongDuration.inMilliseconds}');
  }

  // 播放一首歌
  void playSong(Song song) {
    _songs.insert(curIndex, song);
    play();
  }

  // 播放很多歌
  void playSongs(List<Song> songs, {int? index}) {
    _songs = songs;
    if (index != null) curIndex = index;
    play();
  }

  // 添加歌曲
  void addSongs(List<Song> songs) {
    _songs.addAll(songs);
  }

  /// 播放
  void play() async {
    
    // var url = await NetUtils.getMusicURL(null, songId);
    // Provider.of<UserModel>(context, listen: false);
    String? userJson = Context.sp.getString('user');
    if (userJson == null) {
      return;
    }

    User user = User.fromJson(json.decode(userJson));
    String url = "${NetUtils.baseUrl}/rest/stream?u=${user.name}&t=${user.subsonicToken}";
    url += "&s=${user.subsonicSalt}&f=json&v=${NetUtils.version}&c=${NetUtils.clientName}&id=${_songs[curIndex].id}";
    url = Uri.encodeFull(url);
    url += "&token=${user.token!}";
    //url = "http://39.107.224.142:8802/media/music/Beyond/BEYOND%E3%80%90%E6%B5%B7%E9%97%8A%E5%A4%A9%E7%A9%BA%E3%80%91Music%20Video.mp3?token=${user.token!}";
    Source source = UrlSource(url);
    _audioPlayer.play(source);
    saveCurSong();
  }

  /// 暂停、恢复
  void togglePlay(){
    if (_audioPlayer.state == PlayerState.paused) {
      resumePlay();
    } else {
      pausePlay();
    }
  }

  // 暂停
  void pausePlay() {
    _audioPlayer.pause();
  }

  /// 跳转到固定时间
  void seekPlay(int milliseconds){
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    resumePlay();
  }

  /// 恢复播放
  void resumePlay() {
    _audioPlayer.resume();
  }

  /// 下一首
  void nextPlay(){
    if(curIndex >= _songs.length){
      curIndex = 0;
    }else{
      curIndex++;
    }
    play();
  }

  void prePlay(){
    if(curIndex <= 0){
      curIndex = _songs.length - 1;
    }else{
      curIndex--;
    }
    play();
  }

  // 保存当前歌曲到本地
  void saveCurSong(){
    // Application.sp.remove('playing_songs');
    // Application.sp.setStringList('playing_songs', _songs.map((s) => FluroConvertUtils.object2string(s)).toList());
    // Application.sp.setInt('playing_index', curIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _curPositionController.close();
    _audioPlayer.dispose();
  }


}
