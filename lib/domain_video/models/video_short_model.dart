/// VideoShort is used for returning object in search query which won't have the videoUrl
class VideoShortModel {
  String? encodeID;
  String? title;
  String? artistsNames;
  String? thumbnailM;
  List? genreIds;
  String? albumId;
  List? artistsId;

  VideoShortModel({
    this.encodeID,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artistsId,
  });

  factory VideoShortModel.fromJson(Map<String, dynamic> json) {
    return VideoShortModel(
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

final sampleVideoShort = VideoShortModel(
  encodeID: "ZW6CO0FA",
  title: "Khi Phải Quên Đi",
  artistsNames: "Phan Mạnh Quỳnh",
  thumbnailM:
      "https://photo-resize-zmp3.zmdcdn.me/w600_r300x169_jpeg/thumb_video/0/6/06b8b0c81dc95cbe5d1c764b6dc14b87_1405155254.jpg",
  genreIds: ["IWZ9Z08I", "IWZ97FCD"],
  albumId: null,
  artistsId: ["IWZ98O7W"],
);

final sampleListVideoShorts = [
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
  sampleVideoShort,
];
