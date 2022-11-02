
import 'package:listen_books/utils/net_utils.dart';

class MetaData {
  String _artist = '';
  String _hash = '';
  String _album = '';
  num _track = 0;
  String _title = '';
  String _album_art = '';

  MetaData({
    String? artist,
    String? hash,
    String? album,
    num? track,
    String? title,
    String? album_art
  }) {
    _artist = artist ?? '';
    _hash = hash ?? '';
    _album = album ?? '';
    _track = track ?? 0;
    _title = title ?? 'Unkown';
    _album_art = album_art ??  '';
  }

  String get artist => _artist;
  set artist(String artist) => _artist = artist;
  String get hash => _hash;
  set hash(String hash) => _hash = hash;
  String get album => _album;
  set album(String album) => _album = album;
  num get track => _track;
  set track(num track) => _track = track;
  String get title => _title;
  set title(String title) => _title = title;
  String get album_art => _album_art;
  set album_art(String album_art) => _album_art = album;

  MetaData.fromJson(Map<String, dynamic> json) {
    _artist = json['artist'] ?? "未知";
    _hash = json['hash'] ?? "";
    _album = json['album'] ?? "未知";
    _track = json['track'] ?? -1;
    _title = json['title'] ?? "未知";
    _album_art = json['album-art'] ?? "未知";
    if (_album_art == "未知") {
      _album_art = "${NetUtils.baseUrl}/assets/img/default.png";
    } else {
      _album_art = "${NetUtils.baseUrl}/album-art/$_album_art";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['artist'] = _artist;
    data['hash'] = _hash;
    data['album'] = _album;
    data['track'] = _track;
    data['title'] = _title;
    data['album-art'] = _album_art;
    return data;
  }
}
class Song {
  int id = 0; // 歌曲id
  String? filepath; // 歌曲路径
  MetaData? metaData;


  Song(this.id, {this.filepath, this.metaData});

  Song.fromJson(Map<String, dynamic> json)
    : id = json['lokiId'],
      filepath = json['filepath'],
      metaData = MetaData.fromJson(json['metadata']);

  Map<String, dynamic> toJson() => {
    'lokiId': id,
    'filepath': filepath,
    'metadata': metaData?.toJson()
  };

  @override
  String toString() {
    return 'Song{id: $id, name: $filepath, artists: $metaData}';
  }
}
