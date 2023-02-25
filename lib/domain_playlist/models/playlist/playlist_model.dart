import '../../../domain_artist/models/models.dart';
import '../../../domain_hub/model/model.dart';
import '../../../domain_music/models/models.dart';

class PlaylistModel {
  String? encodeId;
  String? title;
  String? thumbnail;
  String? releaseDate;
  String? sortDescription;
  int? releasedAt;
  List<String>? genreIds;
  List<ArtistModel>? artists;
  String? artistsNames;
  String? thumbnailM;
  String? userName;
  String? description;
  String? aliasTitle;
  String? sectionId;
  List<GenresModel>? genres;
  SongsModel? song;

  PlaylistModel({
    this.encodeId,
    this.title,
    this.thumbnail,
    this.releaseDate,
    this.sortDescription,
    this.releasedAt,
    this.genreIds,
    this.artists,
    this.artistsNames,
    this.thumbnailM,
    this.userName,
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
    description = json['description'];
    aliasTitle = json['aliasTitle'];
    sectionId = json['sectionId'];
    if (json['genres'] != null) {
      genres = <GenresModel>[];
      json['genres'].forEach((v) {
        genres!.add(GenresModel.fromJson(v));
      });
    }
    song = json['song'] != null ? SongsModel.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['encodeId'] = encodeId;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
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