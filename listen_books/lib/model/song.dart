
class Song {
  int playCount = 0;
  String playDate = '';
  int rating = 0;
  bool starred = false;
  String starredAt = '';
  int bookmarkPosition = 0;
  String id = '';
  String path = '';
  String title = '';
  String album = '';
  String artistId = '';
  String artist = '';
  String albumArtistId = '';
  String albumArtist = '';
  String albumId = '';
  bool hasCoverArt = false;
  int trackNumber = 0;
  int discNumber = 0;
  int year = 0;
  int size = 0;
  String suffix = '';
  double duration = 0.0;
  int bitRate = 0;
  int channels = 0;
  String genre = '';
  dynamic genres;
  String fullText = '';
  String orderTitle = '';
  String orderAlbumName = '';
  String orderArtistName = '';
  String orderAlbumArtistName = '';
  bool compilation = false;
  String createdAt = '';
  String updatedAt = '';

  Song.fromJson(Map<String, dynamic> json) {
    playCount = json['playCount'] ?? 0;
    playDate = json['playDate'] ?? '';
    rating = json['rating'] ?? 0;
    starred = json['starred'] ?? false;
    starredAt = json['starredAt'] ?? '';
    bookmarkPosition = json['bookmarkPosition'] ?? '';
    id = json['id'] ?? '';
    path = json['path'] ?? '';
    title = json['title'] ?? '';
    album = json['album'] ?? '';
    artistId = json['artistId'] ?? '';
    artist = json['artist'] ?? '';
    albumArtistId = json['albumArtistId'] ?? '';
    albumArtist = json['albumArtist'] ?? '';
    albumId = json['albumId'] ?? '';
    hasCoverArt = json['hasCoverArt'] ?? false;
    trackNumber = json['trackNumber'] ?? 0;
    discNumber = json['discNumber'] ?? 0;
    year = json['year'] ?? 0;
    size = json['size'] ?? 0;
    suffix = json['suffix'] ?? '';
    duration = json['duration'] ?? 0.0;
    bitRate = json['bitRate'] ?? 0;
    channels = json['channels'] ?? 0;
    genre = json['genre'] ?? '';
    genres = json['genres'];
    fullText = json['fullText'] ?? '';
    orderTitle = json['orderTitle'] ?? '';
    orderAlbumName = json['orderAlbumName'] ?? '';
    orderArtistName = json['orderArtistName'] ?? '';
    orderAlbumArtistName = json['orderAlbumArtistName'] ?? '';
    compilation = json['compilation'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['playCount'] = playCount;
    data['playDate'] = playDate;
    data['rating'] = rating;
    data['starred'] = starred;
    data['starredAt'] = starredAt;
    data['bookmarkPosition'] = bookmarkPosition;
    data['id'] = id;
    data['path'] = path;
    data['title'] = title;
    data['album'] = album;
    data['artistId'] = artistId;
    data['artist'] = artist;
    data['albumArtistId'] = albumArtistId;
    data['albumArtist'] = albumArtist;
    data['albumId'] = albumId;
    data['hasCoverArt'] = hasCoverArt;
    data['trackNumber'] = trackNumber;
    data['discNumber'] = discNumber;
    data['year'] = year;
    data['size'] = size;
    data['suffix'] = suffix;
    data['duration'] = duration;
    data['bitRate'] = bitRate;
    data['channels'] = channels;
    data['genre'] = genre;
    data['genres'] = genres;
    data['fullText'] = fullText;
    data['orderTitle'] = orderTitle;
    data['orderAlbumName'] = orderAlbumName;
    data['orderAlbumArtistName'] = orderAlbumArtistName;
    data['compilation'] = compilation;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class SongList {
  List<Song> songs = [];

  SongList({List<Song>? songs}) {
    songs = songs??[];
  }
  SongList.fromJson(List<dynamic>? json) {
    if (json == null) {
      return;
    }

    for (var album in json) {
        songs.add(Song.fromJson(album));
      }
  }
}
class SongDirectories {
  String name = "";

  SongDirectories.fromJson(Map<String, dynamic> json)
    : name = json["name"];

  Map<String, dynamic> toJson() => {
    "name": name
  };

  @override
  String toString() {
    return 'SongDirectories{name: $name}';
  }
}
