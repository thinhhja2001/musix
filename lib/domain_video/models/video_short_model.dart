import 'package:musix/domain_artist/models/get_artist_model/artist_model.dart';
import 'package:musix/domain_video/entities/video_short.dart';

import '../../domain_artist/utils/utils.dart';

/// VideoShort is used for returning object in search query which won't have the videoUrl
class VideoShortModel {
  String? encodeID;
  String? title;
  String? artistsNames;
  String? thumbnailM;
  List? genreIds;
  String? albumId;
  List<ArtistModel>? artists;
  int? duration;
  VideoShortModel({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artists,
    this.duration,
  });

  factory VideoShortModel.fromJson(Map<String, dynamic> json) {
    print("artists is ${json["artists"]}");
    return VideoShortModel(
      encodeID: json["encodeId"],
      title: json["title"],
      artistsNames: json["artistsNames"],
      thumbnailM: json["thumbnailM"],
      genreIds: json["genres"]?.map((genre) => genre["id"]).toList(),
      albumId: json["album"]?["id"],
      artists: json["artists"]
          ?.map((artist) => ArtistModel.fromJson(artist))
          .toList()
          .cast<ArtistModel>(),
      duration: json["duration"],
    );
  }
  Map<String, dynamic> toJson() => {
        "encodeId": encodeID,
        "title": title,
        "artistsNames": artistsNames,
        "thumbnailM": thumbnailM,
        "genreIds": genreIds,
        "albumId": albumId,
        "artists": artists,
        "duration": duration,
      };
}

final sampleVideoShort = VideoShort(
  encodeID: "ZW6CO0FA",
  title: "Khi Phải Quên Đi",
  artistsNames: "Phan Mạnh Quỳnh",
  artists: [
    convertArtistFromModel(ArtistModel.fromJson({
      "id": "IWZ98O7W",
      "name": "Phan Mạnh Quỳnh",
      "alias": "Phan-Manh-Quynh",
      "playlistId": "ZWZAEBZF",
      "cover": null,
      "thumbnail":
          "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/avatars/1/6/a/d/16ad38a571e873f840bbfc0d97214baa.jpg",
      "biography": null,
      "sortBiography": null,
      "thumbnailM":
          "https://photo-resize-zmp3.zmdcdn.me/w360_r1x1_jpeg/avatars/1/6/a/d/16ad38a571e873f840bbfc0d97214baa.jpg",
      "national": null,
      "birthday": null,
      "realname": null
    }))!
  ],
  thumbnailM:
      "https://photo-resize-zmp3.zmdcdn.me/w600_r300x169_jpeg/thumb_video/0/6/06b8b0c81dc95cbe5d1c764b6dc14b87_1405155254.jpg",
  genreIds: ["IWZ9Z08I", "IWZ97FCD"],
  duration: 417,
  albumId: null,
);

final sampleListVideoShorts = [
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
];
