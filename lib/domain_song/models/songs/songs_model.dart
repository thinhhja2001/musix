import '../models.dart';

class SongsModel {
  List<SongInfoModel>? items;
  int? total;
  int? totalDuration;

  SongsModel({this.items, this.total, this.totalDuration});

  SongsModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <SongInfoModel>[];
      json['items'].forEach((v) {
        items!.add(SongInfoModel.fromJson(v));
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

// class SongModel {
//   String? encodeId;
//   String? title;
//   String? alias;
//   bool? isOffical;
//   String? username;
//   String? artistsNames;
//   List<ArtistModel>? artists;
//   bool? isWorldWide;
//   String? thumbnailM;
//   String? thumbnail;
//   int? duration;
//   int? releaseDate;
//   List<String>? genreIds;
//   int? radioId;
//   bool? isIndie;
//   bool? hasLyric;
//   String? mvlink;
//   PlaylistModel? album;
//
//   SongModel({
//     this.encodeId,
//     this.title,
//     this.alias,
//     this.isOffical,
//     this.username,
//     this.artistsNames,
//     this.artists,
//     this.isWorldWide,
//     this.thumbnailM,
//     this.thumbnail,
//     this.duration,
//     this.releaseDate,
//     this.genreIds,
//     this.radioId,
//     this.isIndie,
//     this.hasLyric,
//     this.mvlink,
//     this.album,
//   });
//
//   SongModel.fromJson(Map<String, dynamic> json) {
//     encodeId = json['encodeId'];
//     title = json['title'];
//     alias = json['alias'];
//     isOffical = json['isOffical'];
//     username = json['username'];
//     artistsNames = json['artistsNames'];
//     if (json['artists'] != null) {
//       artists = <ArtistModel>[];
//       json['artists'].forEach((v) {
//         artists!.add(ArtistModel.fromJson(v));
//       });
//     }
//     isWorldWide = json['isWorldWide'];
//     thumbnailM = json['thumbnailM'];
//     thumbnail = json['thumbnail'];
//     duration = json['duration'];
//     releaseDate = json['releaseDate'];
//     genreIds = json['genreIds'].cast<String>();
//     radioId = json['radioId'];
//     isIndie = json['isIndie'];
//     hasLyric = json['hasLyric'];
//     mvlink = json['mvlink'];
//     album =
//     json['album'] != null ? PlaylistModel.fromJson(json['album']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['encodeId'] = encodeId;
//     data['title'] = title;
//     data['alias'] = alias;
//     data['isOffical'] = isOffical;
//     data['username'] = username;
//     data['artistsNames'] = artistsNames;
//     if (artists != null) {
//       data['artists'] = artists!.map((v) => v.toJson()).toList();
//     }
//     data['isWorldWide'] = isWorldWide;
//     data['thumbnailM'] = thumbnailM;
//     data['thumbnail'] = thumbnail;
//     data['duration'] = duration;
//     data['releaseDate'] = releaseDate;
//     data['genreIds'] = genreIds;
//     data['radioId'] = radioId;
//     data['isIndie'] = isIndie;
//     data['hasLyric'] = hasLyric;
//     data['mvlink'] = mvlink;
//     if (album != null) {
//       data['album'] = album!.toJson();
//     }
//     return data;
//   }
// }
