import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:listen_books/model/media_list.dart';
import 'package:listen_books/utils/media_util.dart';

enum ControlPlayerState { loading, playing, paused, stopped, completed }

class MusicListener {
  Function getName;
  Function onLoading;
  Function onStart;
  Function onPosition;
  Function onStateChanged;
  Function onError;
  MusicListener(
      {required this.getName,
      required this.onLoading,
      required this.onStart,
      required this.onPosition,
      required this.onStateChanged,
      required this.onError});
}

class MusicController with ChangeNotifier {
  // late AudioPlayer audioPlayer;
  late PlayList playList;

  ControlPlayerState playerState = ControlPlayerState.loading;
  late StreamSubscription _positionSubscription;
  late StreamSubscription _audioPlayerStateSubscription;

  late Map song;
  int duration = 0;
  int position = 0;
  String url = '';
  List<MusicListener> musicListeners = [];

  MusicController() {
    // if (audioPlayer == null) {
    //   init();
    // }
  }

  void addMusicListener(MusicListener listener) {
    print('addMusicListener');
    if (!this.musicListeners.contains(listener)) {
      this.musicListeners.add(listener);
    }
  }

  void removeMusicListener(MusicListener listener) {
    print('removeMusicListener ${listener.getName()}');
    this.musicListeners.remove(listener);
  }

  void notifyMusicListeners(Function event) {
    //print('notifyMusicListeners, musicListeners: ${musicListeners.length}');
    musicListeners.forEach((listener) => event(listener));
  }

  // void init() {
  //   // audioPlayer = AudioPlayer();
  //   playList = PlayList();

  //   _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) {
  //     position = p.inMilliseconds;
  //     notifyMusicListeners((listener) => listener.onPosition(position));
  //   });
  //   _audioPlayerStateSubscription =
  //       audioPlayer.onPlayerStateChanged.listen((event) {
  //     print(
  //         "AudioPlayer onPlayerStateChanged, last state: $playerState, currentState: $event");

  //     if (event == AudioPlayerState.PLAYING) {
  //       playerState = PlayerState.playing;
  //       //if (duration == 0) {
  //       duration = audioPlayer.duration.inMilliseconds;
  //       notifyMusicListeners((listener) => listener.onStart(duration));
  //       print("AudioPlayer start, duration:$duration");
  //       //}
  //     } else if (event == AudioPlayerState.PAUSED) {
  //       playerState = PlayerState.paused;
  //     } else if (event == AudioPlayerState.STOPPED) {
  //       position = 0;
  //       playerState = PlayerState.stopped;
  //     } else if (event == AudioPlayerState.COMPLETED) {
  //       position = 0;
  //       playerState = PlayerState.completed;
  //       print('????????????');
  //       onComplete();
  //     }
  //     notifyMusicListeners((listener) => listener.onStateChanged(playerState));
  //     print("AudioPlayer onPlayerStateChanged: $playerState");
  //   }, onError: (msg) {
  //     notifyMusicListeners((listener) => listener.onError(msg));
  //     print("AudioPlayer onError: $msg");
  //   });
  // }

  void dispose() {
    super.dispose();
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    musicListeners.clear();
    // audioPlayer?.stop();
  }

  void setPlayList(List list, int currentIndex) {
    playList.setPlayList(list, currentIndex);
  }

  void playIndex(int index) {
    playList.setCurrentIndex(index);
    startSong();
    notifyListeners();
  }

  Future startSong() async {
    Map? newSong = getCurrentSong();
    if (newSong == null) {
      return;
    }

    // ?????????????????????????????????????????????
    bool isContinue = song['id'] == newSong['id'];
    if (!isContinue) {
      song = newSong;
    }

    notifyMusicListeners((listener) => listener.onLoading());

    if (isContinue) {
      play(path: this.url);
    } else {  // ??????????????????????????????????????????????????????
      MediaUtil.getPlayPath(song).then((playPath) {
      play(path: playPath);
    });
    }
    
  }

  Future play({required String path}) async {
    if (path == null && this.url == null) {
      print('Error: empty url!');
      return;
    }
    // ????????????url????????????????????????????????????????????????????????????url
    bool isContinue = path == this.url;
    if (!isContinue) {
      this.url = path;
      if (playerState != ControlPlayerState.loading) {
        // await audioPlayer.stop(); // ??????????????????await?????????????????????????????????????????????
      }
      // ??????????????????????????????????????????
      duration = 0;
      notifyMusicListeners(
          (listener) => listener.onStateChanged(ControlPlayerState.loading));
    }

    if (path == this.url && playerState == ControlPlayerState.paused) {
      print('????????????????????????????????????????????????????????????????????? path: $path , url: $url ');
      pause();
      notifyMusicListeners((listener) => listener.onStart(duration));
      notifyMusicListeners((listener) => listener.onPosition(position));
    } else {
      bool isLocal = !this.url.startsWith('http');
      print("start play: $url , isLocal: $isLocal, playerState: $playerState ");
      // await audioPlayer.play(this.url, isLocal: isLocal);
    }
  }

  Future pause() async {
    saveHistory();
    // await audioPlayer?.pause();
  }

  Future seek(double millseconds) async {
    // await audioPlayer?.seek(millseconds / 1000);
    if (playerState == ControlPlayerState.paused) {
      //play();
    }
  }

  Future stop() async {
    // await audioPlayer?.stop();
  }

  Future toggle() async {
    if (playerState == ControlPlayerState.playing) {
      await pause();
    } else {
      await play(path: '');
    }
  }

  Map? next() {
    saveHistory();
    Map? item;
    if (playList.cycleType == CycleType.random) {
      item = playList.randomNext();
    } else{
      item = playList.next();
    }
    
    if (item != null) {
      startSong();
    }
    return item;
  }

  Map? previous() {
    saveHistory();
    Map? item;
    if (playList.cycleType == CycleType.random) {
      item = playList.randomNext();
    } else{
      item = playList.previous();
    }
    
    if (item != null) {
      startSong();
    }
    return item;
  }

  int getCurrentIndex() {
    return playList.getCurrentIndex();
  }

  Map? getCurrentSong() {
    return playList.getCurrentSong();
  }

  ControlPlayerState getCurrentState() {
    return playerState;
  }

  int getPosition() {
    return position;
  }

  void onComplete() {
    Map? nextSong;
    // ?????????????????????????????????????????????
    if (playList.cycleType == CycleType.one) {
      nextSong = getCurrentSong();
      startSong();
    } else {
      nextSong = next();
    }
    if (nextSong == null) {
      notifyMusicListeners(
          (listener) => listener.onStateChanged(ControlPlayerState.stopped));
    }
    notifyListeners();
  }

  void saveHistory() {
    // ?????????????????????????????????
    print("saveHistory, ???????????????????????????${position~/1000}");
    if (position > 30*1000) { // ??????30????????????
      // HistoryDB().addHistory(this.song);
    }
    
  }
}
