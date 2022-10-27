import 'dart:math';

enum CycleType { queue, one, random }

class PlayList {
  List _songList = [];
  int _index = 0;
  CycleType cycleType = CycleType.queue;

  setPlayList(List list, int currentIndex) {
    _songList = list;
    _index = currentIndex;
  }

  setCurrentIndex(int index) {
    _index = index;
  }

  Map? getCurrentSong() {
    if (_index < 0 || _index >= _songList.length) {
      return null;
    }
    return _songList[_index];
  }

  Map? next() {
    if (_songList.isEmpty) {
      return null;
    }
    _index++;
    if (_index >= _songList.length) {
      _index = 0;
    }
    return _songList[_index];
  }

  Map? previous() {
    if (_songList.isEmpty) {
      return null;
    }
    _index--;
    if (_index < 0) {
      _index = _songList.length - 1;
    }
    return _songList[_index];
  }

  Map? randomNext() {
    if (_songList.isEmpty) {
      return null;
    }
    int rdmIndex = 0;
    if (_songList.length > 1) {
      rdmIndex = Random().nextInt(_songList.length);
      if (rdmIndex == _index) {
        // 如果和当前index相同，就+1。
        rdmIndex++;
        if (rdmIndex >= _songList.length) {
          rdmIndex = 0;
        }
      }
    }
    _index = rdmIndex;
    return _songList[_index];
  }

  int getCurrentIndex() {
    return _index;
  }

  void changCycleType() {
    if (cycleType == CycleType.queue) {
      cycleType = CycleType.one;
    } else if (cycleType == CycleType.one) {
      cycleType = CycleType.random;
    } else {
      cycleType = CycleType.queue;
    }
  }

  String getCycleName() {
    String cycleName;
    switch(cycleType) {
      case CycleType.queue: cycleName = '顺序播放';break;
      case CycleType.one: cycleName = '单曲循环';break;
      case CycleType.random: cycleName = '随机播放';break;
    }
    return cycleName;
  }
}
