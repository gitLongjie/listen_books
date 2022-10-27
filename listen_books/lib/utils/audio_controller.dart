import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/foundation.dart';

import 'package:listen_books/model/media_list.dart';
import 'package:listen_books/utils/media_util.dart';

enum PlayerState { loading, playing, paused, stopped, completed }

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
  late AudioPlayer audioPlayer;
  late PlayList playList;

  PlayerState playerState = PlayerState.loading;
  late StreamSubscription _positionSubscription;
  late StreamSubscription _audioPlayerStateSubscription;

  late Map song;
  int duration = 0;
  int position = 0;
  String url = '';
  List<MusicListener> musicListeners = [];

  MusicController() {
    if (audioPlayer == null) {
      init();
    }
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

  void init() {
    audioPlayer = AudioPlayer();
    playList = PlayList();

    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) {
      position = p.inMilliseconds;
      notifyMusicListeners((listener) => listener.onPosition(position));
    });
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((event) {
      print(
          "AudioPlayer onPlayerStateChanged, last state: $playerState, currentState: $event");

      if (event == AudioPlayerState.PLAYING) {
        playerState = PlayerState.playing;
        //if (duration == 0) {
        duration = audioPlayer.duration.inMilliseconds;
        notifyMusicListeners((listener) => listener.onStart(duration));
        print("AudioPlayer start, duration:$duration");
        //}
      } else if (event == AudioPlayerState.PAUSED) {
        playerState = PlayerState.paused;
      } else if (event == AudioPlayerState.STOPPED) {
        position = 0;
        playerState = PlayerState.stopped;
      } else if (event == AudioPlayerState.COMPLETED) {
        position = 0;
        playerState = PlayerState.completed;
        print('播放结束');
        onComplete();
      }
      notifyMusicListeners((listener) => listener.onStateChanged(playerState));
      print("AudioPlayer onPlayerStateChanged: $playerState");
    }, onError: (msg) {
      notifyMusicListeners((listener) => listener.onError(msg));
      print("AudioPlayer onError: $msg");
    });
  }

  void dispose() {
    super.dispose();
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    musicListeners.clear();
    audioPlayer?.stop();
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

    // 是否将要播放的歌曲就是当前歌曲
    bool isContinue = song['id'] == newSong['id'];
    if (!isContinue) {
      song = newSong;
    }

    notifyMusicListeners((listener) => listener.onLoading());

    if (isContinue) {
      play(path: this.url);
    } else {  // 如果是播放新歌，就重新获取播放地址。
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
    // 如果参数url为空，或者和之前一样，说明是继续播放当前url
    bool isContinue = path == this.url;
    if (!isContinue) {
      this.url = path;
      if (playerState != PlayerState.loading) {
        await audioPlayer.stop(); // 注意这儿要用await，不然异步到后面，状态会不对。
      }
      // 不是继续播放，就进入加载状态
      duration = 0;
      notifyMusicListeners(
          (listener) => listener.onStateChanged(PlayerState.loading));
    }

    if (path == this.url && playerState == PlayerState.paused) {
      print('播放相同的歌曲，从暂停界面切换过来，继续暂停。 path: $path , url: $url ');
      pause();
      notifyMusicListeners((listener) => listener.onStart(duration));
      notifyMusicListeners((listener) => listener.onPosition(position));
    } else {
      bool isLocal = !this.url.startsWith('http');
      print("start play: $url , isLocal: $isLocal, playerState: $playerState ");
      await audioPlayer.play(this.url, isLocal: isLocal);
    }
  }

  Future pause() async {
    saveHistory();
    await audioPlayer?.pause();
  }

  Future seek(double millseconds) async {
    await audioPlayer?.seek(millseconds / 1000);
    if (playerState == PlayerState.paused) {
      //play();
    }
  }

  Future stop() async {
    await audioPlayer?.stop();
  }

  Future toggle() async {
    if (playerState == PlayerState.playing) {
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

  PlayerState getCurrentState() {
    return playerState;
  }

  int getPosition() {
    return position;
  }

  void onComplete() {
    Map? nextSong;
    // 如果单曲循环，就还是当前歌曲。
    if (playList.cycleType == CycleType.one) {
      nextSong = getCurrentSong();
      startSong();
    } else {
      nextSong = next();
    }
    if (nextSong == null) {
      notifyMusicListeners(
          (listener) => listener.onStateChanged(PlayerState.stopped));
    }
    notifyListeners();
  }

  void saveHistory() {
    // 将上一首保存到历史记录
    print("saveHistory, 当前歌曲播放时长：${position~/1000}");
    if (position > 30*1000) { // 超过30秒才保存
      // HistoryDB().addHistory(this.song);
    }
    
  }
}
