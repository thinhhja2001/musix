/// VideoShort is used for returning object in search query which won't have the videoUrl
class VideoShort {
  String encodeID;
  String title;
  String artistsNames;
  String thumbnailM;
  List? genreIds;
  String? albumId;
  List? artistsId;

  VideoShort({
    required this.encodeID,
    required this.title,
    required this.artistsNames,
    required this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artistsId,
  });

  factory VideoShort.fromJson(Map<String, dynamic> json) {
    return VideoShort(
      encodeID: json["encodeId"],
      title: json["title"],
      artistsNames: json["artistsNames"],
      thumbnailM: json["thumbnailM"],
      genreIds: json["genres"]?.map((genre) => genre["id"]).toList(),
      albumId: json["album"]?["id"],
      artistsId: json["artists"]?.map((artist) => artist["id"]).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        "encodeId": encodeID,
        "title": title,
        "artistsNames": artistsNames,
        "thumbnailM": thumbnailM,
        "genreIds": genreIds,
        "albumId": albumId,
        "artistsId": artistsId,
      };
}
