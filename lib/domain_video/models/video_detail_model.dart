import 'package:musix/domain_video/models/models.dart';

import '../../domain_artist/models/models.dart';

/// VideoShort is used for returning object in getInfo() which will have the videoUrl

class VideoDetailModel {
  String? encodeID;
  String? title;
  String? artistsNames;
  String? thumbnailM;
  List? genreIds;
  String? albumId;
  List<ArtistModel>? artists;
  int? duration;
  String? videoUrl;
  List<VideoShortModel>? recommends;
  DateTime? createdAt;
  VideoDetailModel({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.videoUrl,
    this.albumId,
    this.artists,
    this.duration,
    this.recommends,
    this.createdAt,
  });

  factory VideoDetailModel.fromJson(Map<String, dynamic> json) {
    // To get the best resolution available
    // Video url could be 128p, 360p, 480p, 720p, 1080p

    final videosUrl = json["streaming"]["mp4"] as Map<String, dynamic>;
    // print(videosUrl.keys);
    final videoUrl = videosUrl[videosUrl.keys.last];
    const secondsToMillisecond = 1000;
    return VideoDetailModel(
      encodeID: json["encodeId"],
      title: json["title"],
      artistsNames: json["artistsNames"],
      thumbnailM: json["thumbnailM"],
      genreIds: json["genres"]?.map((genre) => genre["id"]).toList(),
      albumId: json["album"]?["id"],
      artists: json["artists"]
          ?.map(
            (artist) => ArtistModel.fromJson(artist),
          )
          .toList()
          .cast<ArtistModel>(),
      recommends: json["recommends"]
          ?.map((recommend) => VideoShortModel.fromJson(recommend))
          .toList()
          .cast<VideoShortModel>(),
      duration: json["duration"],
      videoUrl: videoUrl,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          json["createdAt"] * secondsToMillisecond),
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
        "videoUrl": videoUrl,
        "recommends": recommends,
        "duration": duration
      };
}
