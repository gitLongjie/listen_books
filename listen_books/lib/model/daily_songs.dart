import 'package:listen_books/model/song.dart';


class DailySongsData {
  List<Song> _songs = [];

  DailySongsData({List<Song>? songs}) {
    _songs = songs ?? [];
  }

  List<Song>? get songs => _songs;
  set recommend(List<Song> songs) => _songs = songs;

  DailySongsData.fromJson(List<dynamic>? json) {
    if (json != null) {
      for (var v in json) {
        _songs.add(Song.fromJson(v));
      }
    }
  }

  List<dynamic> toJson() {
    final List<dynamic> data = _songs.toList();
    return data;
  }
}


/*


class Artists {
  String _name;
  num _id;
  num _picId;
  num _img1v1Id;
  String _briefDesc;
  String _picUrl;
  String _img1v1Url;
  num _albumSize;
  String _trans;
  num _musicSize;
  num _topicPerson;

  Artists(
      {String name,
        num id,
        num picId,
        num img1v1Id,
        String briefDesc,
        String picUrl,
        String img1v1Url,
        num albumSize,
        String trans,
        num musicSize,
        num topicPerson}) {
    this._name = name;
    this._id = id;
    this._picId = picId;
    this._img1v1Id = img1v1Id;
    this._briefDesc = briefDesc;
    this._picUrl = picUrl;
    this._img1v1Url = img1v1Url;
    this._albumSize = albumSize;
    this._trans = trans;
    this._musicSize = musicSize;
    this._topicPerson = topicPerson;
  }

  String get name => _name;
  set name(String name) => _name = name;
  num get id => _id;
  set id(num id) => _id = id;
  num get picId => _picId;
  set picId(num picId) => _picId = picId;
  num get img1v1Id => _img1v1Id;
  set img1v1Id(num img1v1Id) => _img1v1Id = img1v1Id;
  String get briefDesc => _briefDesc;
  set briefDesc(String briefDesc) => _briefDesc = briefDesc;
  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;
  String get img1v1Url => _img1v1Url;
  set img1v1Url(String img1v1Url) => _img1v1Url = img1v1Url;
  num get albumSize => _albumSize;
  set albumSize(num albumSize) => _albumSize = albumSize;
  String get trans => _trans;
  set trans(String trans) => _trans = trans;
  num get musicSize => _musicSize;
  set musicSize(num musicSize) => _musicSize = musicSize;
  num get topicPerson => _topicPerson;
  set topicPerson(num topicPerson) => _topicPerson = topicPerson;

  Artists.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];
    _picId = json['picId'];
    _img1v1Id = json['img1v1Id'];
    _briefDesc = json['briefDesc'];
    _picUrl = json['picUrl'];
    _img1v1Url = json['img1v1Url'];
    _albumSize = json['albumSize'];
    _trans = json['trans'];
    _musicSize = json['musicSize'];
    _topicPerson = json['topicPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._id;
    data['picId'] = this._picId;
    data['img1v1Id'] = this._img1v1Id;
    data['briefDesc'] = this._briefDesc;
    data['picUrl'] = this._picUrl;
    data['img1v1Url'] = this._img1v1Url;
    data['albumSize'] = this._albumSize;
    data['trans'] = this._trans;
    data['musicSize'] = this._musicSize;
    data['topicPerson'] = this._topicPerson;
    return data;
  }
}

class Album {
  String _name;
  num _id;
  String _type;
  num _size;
  num _picId;
  String _blurPicUrl;
  num _companyId;
  num _pic;
  String _picUrl;
  num _publishTime;
  String _description;
  String _tags;
  String _company;
  String _briefDesc;
  num _status;
  num _copyrightId;
  String _commentThreadId;
  List<Artists> _artists;
  String _subType;
  num _mark;
  String _picIdStr;

  Album(
      {String name,
        num id,
        String type,
        num size,
        num picId,
        String blurPicUrl,
        num companyId,
        num pic,
        String picUrl,
        num publishTime,
        String description,
        String tags,
        String company,
        String briefDesc,
        Artists artist,
        List<Null> songs,
        List<Null> alias,
        num status,
        num copyrightId,
        String commentThreadId,
        List<Artists> artists,
        String subType,
        Null transName,
        num mark,
        String picIdStr}) {
    this._name = name;
    this._id = id;
    this._type = type;
    this._size = size;
    this._picId = picId;
    this._blurPicUrl = blurPicUrl;
    this._companyId = companyId;
    this._pic = pic;
    this._picUrl = picUrl;
    this._publishTime = publishTime;
    this._description = description;
    this._tags = tags;
    this._company = company;
    this._briefDesc = briefDesc;
    this._status = status;
    this._copyrightId = copyrightId;
    this._commentThreadId = commentThreadId;
    this._artists = artists;
    this._subType = subType;
    this._mark = mark;
    this._picIdStr = picIdStr;
  }

  String get name => _name;
  set name(String name) => _name = name;
  num get id => _id;
  set id(num id) => _id = id;
  String get type => _type;
  set type(String type) => _type = type;
  num get size => _size;
  set size(num size) => _size = size;
  num get picId => _picId;
  set picId(num picId) => _picId = picId;
  String get blurPicUrl => _blurPicUrl;
  set blurPicUrl(String blurPicUrl) => _blurPicUrl = blurPicUrl;
  num get companyId => _companyId;
  set companyId(num companyId) => _companyId = companyId;
  num get pic => _pic;
  set pic(num pic) => _pic = pic;
  String get picUrl => _picUrl;
  set picUrl(String picUrl) => _picUrl = picUrl;
  num get publishTime => _publishTime;
  set publishTime(num publishTime) => _publishTime = publishTime;
  String get description => _description;
  set description(String description) => _description = description;
  String get tags => _tags;
  set tags(String tags) => _tags = tags;
  String get company => _company;
  set company(String company) => _company = company;
  String get briefDesc => _briefDesc;
  set briefDesc(String briefDesc) => _briefDesc = briefDesc;
  num get status => _status;
  set status(num status) => _status = status;
  num get copyrightId => _copyrightId;
  set copyrightId(num copyrightId) => _copyrightId = copyrightId;
  String get commentThreadId => _commentThreadId;
  set commentThreadId(String commentThreadId) =>
      _commentThreadId = commentThreadId;
  List<Artists> get artists => _artists;
  set artists(List<Artists> artists) => _artists = artists;
  String get subType => _subType;
  set subType(String subType) => _subType = subType;
  num get mark => _mark;
  set mark(num mark) => _mark = mark;
  String get picIdStr => _picIdStr;
  set picIdStr(String picIdStr) => _picIdStr = picIdStr;

  Album.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];
    _type = json['type'];
    _size = json['size'];
    _picId = json['picId'];
    _blurPicUrl = json['blurPicUrl'];
    _companyId = json['companyId'];
    _pic = json['pic'];
    _picUrl = json['picUrl'];
    _publishTime = json['publishTime'];
    _description = json['description'];
    _tags = json['tags'];
    _company = json['company'];
    _briefDesc = json['briefDesc'];
    _status = json['status'];
    _copyrightId = json['copyrightId'];
    _commentThreadId = json['commentThreadId'];
    if (json['artists'] != null) {
      _artists = new List<Artists>();
      json['artists'].forEach((v) {
        _artists.add(new Artists.fromJson(v));
      });
    }
    _subType = json['subType'];
    _mark = json['mark'];
    _picIdStr = json['picId_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._id;
    data['type'] = this._type;
    data['size'] = this._size;
    data['picId'] = this._picId;
    data['blurPicUrl'] = this._blurPicUrl;
    data['companyId'] = this._companyId;
    data['pic'] = this._pic;
    data['picUrl'] = this._picUrl;
    data['publishTime'] = this._publishTime;
    data['description'] = this._description;
    data['tags'] = this._tags;
    data['company'] = this._company;
    data['briefDesc'] = this._briefDesc;
    data['status'] = this._status;
    data['copyrightId'] = this._copyrightId;
    data['commentThreadId'] = this._commentThreadId;
    if (this._artists != null) {
      data['artists'] = this._artists.map((v) => v.toJson()).toList();
    }
    data['subType'] = this._subType;
    data['mark'] = this._mark;
    data['picId_str'] = this._picIdStr;
    return data;
  }
}

class HMusic {
  String _name;
  num _id;
  num _size;
  String _extension;
  num _sr;
  num _dfsId;
  num _bitrate;
  num _playTime;
  num _volumeDelta;

  HMusic(
      {String name,
        num id,
        num size,
        String extension,
        num sr,
        num dfsId,
        num bitrate,
        num playTime,
        num volumeDelta}) {
    this._name = name;
    this._id = id;
    this._size = size;
    this._extension = extension;
    this._sr = sr;
    this._dfsId = dfsId;
    this._bitrate = bitrate;
    this._playTime = playTime;
    this._volumeDelta = volumeDelta;
  }

  String get name => _name;
  set name(String name) => _name = name;
  num get id => _id;
  set id(num id) => _id = id;
  num get size => _size;
  set size(num size) => _size = size;
  String get extension => _extension;
  set extension(String extension) => _extension = extension;
  num get sr => _sr;
  set sr(num sr) => _sr = sr;
  num get dfsId => _dfsId;
  set dfsId(num dfsId) => _dfsId = dfsId;
  num get bitrate => _bitrate;
  set bitrate(num bitrate) => _bitrate = bitrate;
  num get playTime => _playTime;
  set playTime(num playTime) => _playTime = playTime;
  num get volumeDelta => _volumeDelta;
  set volumeDelta(num volumeDelta) => _volumeDelta = volumeDelta;

  HMusic.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _id = json['id'];
    _size = json['size'];
    _extension = json['extension'];
    _sr = json['sr'];
    _dfsId = json['dfsId'];
    _bitrate = json['bitrate'];
    _playTime = json['playTime'];
    _volumeDelta = json['volumeDelta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._id;
    data['size'] = this._size;
    data['extension'] = this._extension;
    data['sr'] = this._sr;
    data['dfsId'] = this._dfsId;
    data['bitrate'] = this._bitrate;
    data['playTime'] = this._playTime;
    data['volumeDelta'] = this._volumeDelta;
    return data;
  }
}

class Privilege {
  num _id;
  num _fee;
  num _payed;
  num _st;
  num _pl;
  num _dl;
  num _sp;
  num _cp;
  num _subp;
  bool _cs;
  num _maxbr;
  num _fl;
  bool _toast;
  num _flag;
  bool _preSell;

  Privilege(
      {num id,
        num fee,
        num payed,
        num st,
        num pl,
        num dl,
        num sp,
        num cp,
        num subp,
        bool cs,
        num maxbr,
        num fl,
        bool toast,
        num flag,
        bool preSell}) {
    this._id = id;
    this._fee = fee;
    this._payed = payed;
    this._st = st;
    this._pl = pl;
    this._dl = dl;
    this._sp = sp;
    this._cp = cp;
    this._subp = subp;
    this._cs = cs;
    this._maxbr = maxbr;
    this._fl = fl;
    this._toast = toast;
    this._flag = flag;
    this._preSell = preSell;
  }

  num get id => _id;
  set id(num id) => _id = id;
  num get fee => _fee;
  set fee(num fee) => _fee = fee;
  num get payed => _payed;
  set payed(num payed) => _payed = payed;
  num get st => _st;
  set st(num st) => _st = st;
  num get pl => _pl;
  set pl(num pl) => _pl = pl;
  num get dl => _dl;
  set dl(num dl) => _dl = dl;
  num get sp => _sp;
  set sp(num sp) => _sp = sp;
  num get cp => _cp;
  set cp(num cp) => _cp = cp;
  num get subp => _subp;
  set subp(num subp) => _subp = subp;
  bool get cs => _cs;
  set cs(bool cs) => _cs = cs;
  num get maxbr => _maxbr;
  set maxbr(num maxbr) => _maxbr = maxbr;
  num get fl => _fl;
  set fl(num fl) => _fl = fl;
  bool get toast => _toast;
  set toast(bool toast) => _toast = toast;
  num get flag => _flag;
  set flag(num flag) => _flag = flag;
  bool get preSell => _preSell;
  set preSell(bool preSell) => _preSell = preSell;

  Privilege.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fee = json['fee'];
    _payed = json['payed'];
    _st = json['st'];
    _pl = json['pl'];
    _dl = json['dl'];
    _sp = json['sp'];
    _cp = json['cp'];
    _subp = json['subp'];
    _cs = json['cs'];
    _maxbr = json['maxbr'];
    _fl = json['fl'];
    _toast = json['toast'];
    _flag = json['flag'];
    _preSell = json['preSell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fee'] = this._fee;
    data['payed'] = this._payed;
    data['st'] = this._st;
    data['pl'] = this._pl;
    data['dl'] = this._dl;
    data['sp'] = this._sp;
    data['cp'] = this._cp;
    data['subp'] = this._subp;
    data['cs'] = this._cs;
    data['maxbr'] = this._maxbr;
    data['fl'] = this._fl;
    data['toast'] = this._toast;
    data['flag'] = this._flag;
    data['preSell'] = this._preSell;
    return data;
  }
}
*/
