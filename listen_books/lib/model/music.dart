class MusicData {
  num mvid;
  String picUrl;
  String songName;
  String artists;
  int index;

  MusicData({
    required this.mvid,
    required this.picUrl,
    required this.songName,
    required this.artists,
    this.index = 0,
  });
}
