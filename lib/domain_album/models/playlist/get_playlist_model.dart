class GetPlaylistModel {
  int? err;
  String? msg;
  PlaylistModel? data;
  int? timestamp;

  GetPlaylistModel({this.err, this.msg, this.data, this.timestamp});

  GetPlaylistModel.fromJson(Map<String, dynamic> json) {
    err = json['err'];
    msg = json['msg'];
    data = json['data'] != null ? PlaylistModel.fromJson(json['data']) : null;
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

class PlaylistModel {
  String? encodeId;
  String? title;
  String? thumbnail;
  bool? isoffical;
  bool? isIndie;
  String? releaseDate;
  String? sortDescription;
  int? releasedAt;
  List<String>? genreIds;
  List<ArtistModel>? artists;
  String? artistsNames;
  String? thumbnailM;
  String? userName;
  bool? isAlbum;
  bool? isSingle;
  String? description;
  String? aliasTitle;
  String? sectionId;
  List<GenresInGetPlaylistModel>? genres;
  SongsModel? song;

  PlaylistModel({
    this.encodeId,
    this.title,
    this.thumbnail,
    this.isoffical,
    this.isIndie,
    this.releaseDate,
    this.sortDescription,
    this.releasedAt,
    this.genreIds,
    this.artists,
    this.artistsNames,
    this.thumbnailM,
    this.userName,
    this.isAlbum,
    this.isSingle,
    this.description,
    this.aliasTitle,
    this.sectionId,
    this.genres,
    this.song,
  });

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    encodeId = json['encodeId'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    isoffical = json['isoffical'];
    isIndie = json['isIndie'];
    releaseDate = json['releaseDate'];
    sortDescription = json['sortDescription'];
    releasedAt = json['releasedAt'];
    genreIds = json['genreIds'].cast<String>();
    if (json['artists'] != null) {
      artists = <ArtistModel>[];
      json['artists'].forEach((v) {
        artists!.add(ArtistModel.fromJson(v));
      });
    }
    artistsNames = json['artistsNames'];
    thumbnailM = json['thumbnailM'];
    userName = json['userName'];
    isAlbum = json['isAlbum'];
    isSingle = json['isSingle'];
    description = json['description'];
    aliasTitle = json['aliasTitle'];
    sectionId = json['sectionId'];
    if (json['genres'] != null) {
      genres = <GenresInGetPlaylistModel>[];
      json['genres'].forEach((v) {
        genres!.add(GenresInGetPlaylistModel.fromJson(v));
      });
    }
    song = json['song'] != null ? SongsModel.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encodeId'] = encodeId;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['isoffical'] = isoffical;
    data['isIndie'] = isIndie;
    data['releaseDate'] = releaseDate;
    data['sortDescription'] = sortDescription;
    data['releasedAt'] = releasedAt;
    data['genreIds'] = genreIds;
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['artistsNames'] = artistsNames;
    data['thumbnailM'] = thumbnailM;
    data['userName'] = userName;
    data['isAlbum'] = isAlbum;
    data['isSingle'] = isSingle;
    data['description'] = description;
    data['aliasTitle'] = aliasTitle;
    data['sectionId'] = sectionId;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    if (song != null) {
      data['song'] = song!.toJson();
    }
    return data;
  }
}

class ArtistModel {
  String? id;
  String? name;
  String? alias;
  String? thumbnail;
  String? thumbnailM;
  String? playlistId;

  ArtistModel({
    this.id,
    this.name,
    this.alias,
    this.thumbnail,
    this.thumbnailM,
    this.playlistId,
  });

  ArtistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    thumbnail = json['thumbnail'];
    thumbnailM = json['thumbnailM'];
    playlistId = json['playlistId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['thumbnail'] = thumbnail;
    data['thumbnailM'] = thumbnailM;
    data['playlistId'] = playlistId;
    return data;
  }
}

class GenresInGetPlaylistModel {
  String? id;
  String? name;
  String? title;
  String? alias;

  GenresInGetPlaylistModel({
    this.id,
    this.name,
    this.title,
    this.alias,
  });

  GenresInGetPlaylistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['alias'] = alias;
    return data;
  }
}

class SongsModel {
  List<SongModel>? items;
  int? total;
  int? totalDuration;

  SongsModel({this.items, this.total, this.totalDuration});

  SongsModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SongModel>[];
      json['items'].forEach((v) {
        items!.add(SongModel.fromJson(v));
      });
    }
    total = json['total'];
    totalDuration = json['totalDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['totalDuration'] = totalDuration;
    return data;
  }
}

class SongModel {
  String? encodeId;
  String? title;
  String? alias;
  bool? isOffical;
  String? username;
  String? artistsNames;
  List<ArtistModel>? artists;
  bool? isWorldWide;
  String? thumbnailM;
  String? thumbnail;
  int? duration;
  int? releaseDate;
  List<String>? genreIds;
  int? radioId;
  bool? isIndie;
  bool? hasLyric;
  String? mvlink;
  PlaylistModel? album;

  SongModel({
    this.encodeId,
    this.title,
    this.alias,
    this.isOffical,
    this.username,
    this.artistsNames,
    this.artists,
    this.isWorldWide,
    this.thumbnailM,
    this.thumbnail,
    this.duration,
    this.releaseDate,
    this.genreIds,
    this.radioId,
    this.isIndie,
    this.hasLyric,
    this.mvlink,
    this.album,
  });

  SongModel.fromJson(Map<String, dynamic> json) {
    encodeId = json['encodeId'];
    title = json['title'];
    alias = json['alias'];
    isOffical = json['isOffical'];
    username = json['username'];
    artistsNames = json['artistsNames'];
    if (json['artists'] != null) {
      artists = <ArtistModel>[];
      json['artists'].forEach((v) {
        artists!.add(ArtistModel.fromJson(v));
      });
    }
    isWorldWide = json['isWorldWide'];
    thumbnailM = json['thumbnailM'];
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    releaseDate = json['releaseDate'];
    genreIds = json['genreIds'].cast<String>();
    radioId = json['radioId'];
    isIndie = json['isIndie'];
    hasLyric = json['hasLyric'];
    mvlink = json['mvlink'];
    album =
        json['album'] != null ? PlaylistModel.fromJson(json['album']) : null;
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
    data['thumbnail'] = thumbnail;
    data['duration'] = duration;
    data['releaseDate'] = releaseDate;
    data['genreIds'] = genreIds;
    data['radioId'] = radioId;
    data['isIndie'] = isIndie;
    data['hasLyric'] = hasLyric;
    data['mvlink'] = mvlink;
    if (album != null) {
      data['album'] = album!.toJson();
    }
    return data;
  }
}
