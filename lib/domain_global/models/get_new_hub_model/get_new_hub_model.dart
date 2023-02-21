class GetNewHubModel {
  int? err;
  String? msg;
  DataInGetNewHubModel? data;
  int? timestamp;

  GetNewHubModel({this.err, this.msg, this.data, this.timestamp});

  GetNewHubModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null
        ? DataInGetNewHubModel.fromJson(json['data'])
        : null;
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['err'] = err;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class DataInGetNewHubModel {
  String? encodeId;
  String? cover;
  String? thumbnail;
  String? thumbnailHasText;
  String? thumbnailR;
  String? title;
  String? link;
  String? description;
  List<SectionsInGetNewHubModel>? sections;

  DataInGetNewHubModel(
      {this.encodeId,
      this.cover,
      this.thumbnail,
      this.thumbnailHasText,
      this.thumbnailR,
      this.title,
      this.link,
      this.description,
      this.sections});

  DataInGetNewHubModel.fromJson(Map<String, dynamic> json) {
    encodeId = json['encodeId'];
    cover = json['cover'];
    thumbnail = json['thumbnail'];
    thumbnailHasText = json['thumbnailHasText'];
    thumbnailR = json['thumbnailR'];
    title = json['title'];
    link = json['link'];
    description = json['description'];
    if (json['sections'] != null) {
      sections = <SectionsInGetNewHubModel>[];
      json['sections'].forEach((v) {
        sections!.add(SectionsInGetNewHubModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encodeId'] = encodeId;
    data['cover'] = cover;
    data['thumbnail'] = thumbnail;
    data['thumbnailHasText'] = thumbnailHasText;
    data['thumbnailR'] = thumbnailR;
    data['title'] = title;
    data['link'] = link;
    data['description'] = description;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionsInGetNewHubModel {
  String? sectionType;
  String? viewType;
  String? title;
  String? link;
  String? sectionId;
  List<Map<String, dynamic>>? items;

  SectionsInGetNewHubModel(
      {this.sectionType,
      this.viewType,
      this.title,
      this.link,
      this.sectionId,
      this.items});

  SectionsInGetNewHubModel.fromJson(Map<String, dynamic> json) {
    sectionType = json['sectionType'];
    viewType = json['viewType'];
    title = json['title'];
    link = json['link'];
    sectionId = json['sectionId'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sectionType'] = sectionType;
    data['viewType'] = viewType;
    data['title'] = title;
    data['link'] = link;
    data['sectionId'] = sectionId;
    if (items != null) {
      data['items'] = items!;
    }
    return data;
  }
}

class PlaylistsInGetNewHubModel {
  String? encodeId;
  String? title;
  String? thumbnail;
  bool? isoffical;
  String? link;
  bool? isIndie;
  String? releaseDate;
  String? sortDescription;
  int? releasedAt;
  List<String>? genreIds;
  bool? pR;
  List<ArtistsInGetNewHubModel>? artists;
  String? artistsNames;
  int? playItemMode;
  int? subType;
  int? uid;
  String? thumbnailM;
  bool? isShuffle;
  bool? isPrivate;
  String? userName;
  bool? isAlbum;
  String? textType;
  bool? isSingle;

  PlaylistsInGetNewHubModel(
      {this.encodeId,
      this.title,
      this.thumbnail,
      this.isoffical,
      this.link,
      this.isIndie,
      this.releaseDate,
      this.sortDescription,
      this.releasedAt,
      this.genreIds,
      this.pR,
      this.artists,
      this.artistsNames,
      this.playItemMode,
      this.subType,
      this.uid,
      this.thumbnailM,
      this.isShuffle,
      this.isPrivate,
      this.userName,
      this.isAlbum,
      this.textType,
      this.isSingle});

  PlaylistsInGetNewHubModel.fromJson(Map<String, dynamic> json) {
    encodeId = json['encodeId'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    isoffical = json['isoffical'];
    link = json['link'];
    isIndie = json['isIndie'];
    releaseDate = json['releaseDate'];
    sortDescription = json['sortDescription'];
    releasedAt = json['releasedAt'];
    genreIds = json['genreIds'].cast<String>();
    pR = json['PR'];
    if (json['artists'] != null) {
      artists = <ArtistsInGetNewHubModel>[];
      json['artists'].forEach((v) {
        artists!.add(ArtistsInGetNewHubModel.fromJson(v));
      });
    }
    artistsNames = json['artistsNames'];
    playItemMode = json['playItemMode'];
    subType = json['subType'];
    uid = json['uid'];
    thumbnailM = json['thumbnailM'];
    isShuffle = json['isShuffle'];
    isPrivate = json['isPrivate'];
    userName = json['userName'];
    isAlbum = json['isAlbum'];
    textType = json['textType'];
    isSingle = json['isSingle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encodeId'] = encodeId;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['isoffical'] = isoffical;
    data['link'] = link;
    data['isIndie'] = isIndie;
    data['releaseDate'] = releaseDate;
    data['sortDescription'] = sortDescription;
    data['releasedAt'] = releasedAt;
    data['genreIds'] = genreIds;
    data['PR'] = pR;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['artistsNames'] = artistsNames;
    data['playItemMode'] = playItemMode;
    data['subType'] = subType;
    data['uid'] = uid;
    data['thumbnailM'] = thumbnailM;
    data['isShuffle'] = isShuffle;
    data['isPrivate'] = isPrivate;
    data['userName'] = userName;
    data['isAlbum'] = isAlbum;
    data['textType'] = textType;
    data['isSingle'] = isSingle;
    return data;
  }
}

class ArtistsInGetNewHubModel {
  String? id;
  String? name;
  String? link;
  bool? spotlight;
  String? alias;
  String? thumbnail;
  String? thumbnailM;
  bool? isOA;
  bool? isOABrand;
  String? playlistId;
  int? totalFollow;

  ArtistsInGetNewHubModel(
      {this.id,
      this.name,
      this.link,
      this.spotlight,
      this.alias,
      this.thumbnail,
      this.thumbnailM,
      this.isOA,
      this.isOABrand,
      this.playlistId,
      this.totalFollow});

  ArtistsInGetNewHubModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    spotlight = json['spotlight'];
    alias = json['alias'];
    thumbnail = json['thumbnail'];
    thumbnailM = json['thumbnailM'];
    isOA = json['isOA'];
    isOABrand = json['isOABrand'];
    playlistId = json['playlistId'];
    totalFollow = json['totalFollow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['spotlight'] = spotlight;
    data['alias'] = alias;
    data['thumbnail'] = thumbnail;
    data['thumbnailM'] = thumbnailM;
    data['isOA'] = isOA;
    data['isOABrand'] = isOABrand;
    data['playlistId'] = playlistId;
    data['totalFollow'] = totalFollow;
    return data;
  }
}

class SongInGetNewHubModel {
  String? encodeId;
  String? title;
  String? alias;
  bool? isOffical;
  String? username;
  String? artistsNames;
  List<ArtistsInGetNewHubModel>? artists;
  bool? isWorldWide;
  String? thumbnailM;
  String? link;
  String? thumbnail;
  int? duration;
  bool? zingChoice;
  bool? isPrivate;
  bool? preRelease;
  int? releaseDate;
  List<String>? genreIds;
  PlaylistsInGetNewHubModel? album;
  bool? isIndie;
  int? streamingStatus;
  bool? allowAudioAds;
  bool? hasLyric;

  SongInGetNewHubModel({
    this.encodeId,
    this.title,
    this.alias,
    this.isOffical,
    this.username,
    this.artistsNames,
    this.artists,
    this.isWorldWide,
    this.thumbnailM,
    this.link,
    this.thumbnail,
    this.duration,
    this.zingChoice,
    this.isPrivate,
    this.preRelease,
    this.releaseDate,
    this.genreIds,
    this.album,
    this.isIndie,
    this.streamingStatus,
    this.allowAudioAds,
    this.hasLyric,
  });

  SongInGetNewHubModel.fromJson(Map<String, dynamic> json) {
    encodeId = json['encodeId'];
    title = json['title'];
    alias = json['alias'];
    isOffical = json['isOffical'];
    username = json['username'];
    artistsNames = json['artistsNames'];
    if (json['artists'] != null) {
      artists = <ArtistsInGetNewHubModel>[];
      json['artists'].forEach((v) {
        artists!.add(ArtistsInGetNewHubModel.fromJson(v));
      });
    }
    isWorldWide = json['isWorldWide'];
    thumbnailM = json['thumbnailM'];
    link = json['link'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    zingChoice = json['zingChoice'];
    isPrivate = json['isPrivate'];
    preRelease = json['preRelease'];
    releaseDate = json['releaseDate'];
    genreIds = json['genreIds'].cast<String>();
    album = json['album'] != null
        ? PlaylistsInGetNewHubModel.fromJson(json['album'])
        : null;
    isIndie = json['isIndie'];
    streamingStatus = json['streamingStatus'];
    allowAudioAds = json['allowAudioAds'];
    hasLyric = json['hasLyric'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encodeId'] = encodeId;
    data['title'] = title;
    data['alias'] = alias;
    data['isOffical'] = isOffical;
    data['username'] = username;
    data['artistsNames'] = artistsNames;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['isWorldWide'] = isWorldWide;
    data['thumbnailM'] = thumbnailM;
    data['link'] = link;
    data['thumbnail'] = thumbnail;
    data['duration'] = duration;
    data['zingChoice'] = zingChoice;
    data['isPrivate'] = isPrivate;
    data['preRelease'] = preRelease;
    data['releaseDate'] = releaseDate;
    data['genreIds'] = genreIds;
    if (album != null) {
      data['album'] = album!.toJson();
    }
    data['isIndie'] = isIndie;
    data['streamingStatus'] = streamingStatus;
    data['allowAudioAds'] = allowAudioAds;
    data['hasLyric'] = hasLyric;
    return data;
  }
}
