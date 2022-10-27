import 'package:listen_books/utils/local_media_util.dart';

class MediaUtil {
  static String getArtistNames(Map media) {
    if (media.containsKey('artistNames')) {
      return media['artistNames'];
    }

    String names = '';
    List arList;

    if (media.containsKey('ar')) {
      arList = media['ar'];
    } else if (media.containsKey('artists')) {
      arList = media['artists'];
    } else {
      arList = media['song']['artists'];
    }

    bool isFirst = true;
    arList.forEach((ar) {
      if (isFirst) {
        isFirst = false;
        names = ar['name'];
      } else {
        names += " " + ar['name'];
      }
    });
    media['artistNames'] = names;

    return names;
  }

  static String getSongImage(Map media, {int size:100, int width:0, int height:0}) {
    String imgUrl='';
    if (media.containsKey('imageUrl')) {
      imgUrl = media['imageUrl'];
    } else {
      try {
        if (media.containsKey('al')) {
          imgUrl = media['al']['picUrl'];
        } else if (media.containsKey('song')) {// URL_NEW_SONGS里面的数据结构
          imgUrl = media['song']['album']['picUrl'];
        }
        media['imageUrl'] = imgUrl;  
      } catch(e) {
        print(e);
        print(media['name']);
        return '';
      } 
    }

    if (imgUrl.isEmpty) {
      return '';
    }
    if (width > 0 && height > 0) {
      imgUrl += '?param=${width}y$height';
    } else if (size > 0) {
      imgUrl += '?param=${size}y$size';
    }

    //print('imageUrl: $imgUrl');
    return imgUrl;
  }


  static String getSongUrl(Map song) {
    return "https://music.163.com/song/media/outer/url?id=${song['id']}.mp3";
  }


  static Future<String> getPlayPath(Map song) async{
    String localPath = await LocalMediaUtil.getSongLocalPath(song['id']);
    if (await LocalMediaUtil.isFileExists(localPath)) {
      return localPath;
    } else {
      return getSongUrl(song);
    }

    return getSongUrl(song);
  }

  
  static Future<bool> isSongDownloaded(int id) async{
    String localPath = await LocalMediaUtil.getSongLocalPath(id);
    return LocalMediaUtil.isFileExists(localPath);
  }


  static String getArtistImage(Map artist, {int size:100, int width:0, int height:0}) {
    String imgUrl = artist['picUrl'];
    if (width > 0 && height > 0) {
      imgUrl += '?param=${width}y$height';
    } else if (size > 0) {
      imgUrl += '?param=${size}y$size';
    }
    return imgUrl;
  }

}
