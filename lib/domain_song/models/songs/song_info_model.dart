class SongInfoModel {
  SongInfoModel({
    this.encodeId,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.genreIds,
    this.albumId,
    this.artistsId,
  });
  String? encodeId;
  String? title;
  String? artistsNames;
  // Use thumbnailM instead of thumbnail because it will have higher resolution
  String? thumbnailM;
  List<String>? genreIds;
  String? albumId;
  List<String>? artistsId;

  factory SongInfoModel.fromJson(
    Map<String, dynamic> songInfoJson,
  ) {
    return SongInfoModel(
      encodeId: songInfoJson["encodeId"],
      title: songInfoJson['title'],
      artistsNames: songInfoJson['artistsNames'],
      thumbnailM: songInfoJson['thumbnailM'],
      albumId: songInfoJson["album"]?["encodeId"],
      genreIds: songInfoJson["genreIds"] != null
          ? songInfoJson["genreIds"]
              .map((genreId) => genreId as String)
              .toList()
              .cast<String>()
          : [],
      artistsId: songInfoJson["artists"] != null
          ? songInfoJson["artists"]
              ?.map((artist) => artist["id"] as String)
              .toList()
              .cast<String>()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "encodeId": encodeId,
        "title": title,
        "artistsName": artistsNames,
        "thumbnailM": thumbnailM,
        "albumId": albumId,
        "artistsId": artistsId,
        "genreIds": genreIds,
      };
}

SongInfoModel sampleSong = SongInfoModel(
  encodeId: "ZW68AD67",
  title: "Rap God",
  artistsNames: "Eminem",
  genreIds: ["IWZ9Z08O", "IWZ9Z09B"],
  thumbnailM:
      "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/d/0/5/1d057df84228de726b09218407021004.jpg",
  artistsId: ["IWZ9ZOOF"],
  albumId: "ZWZAFD88",
);

List<SongInfoModel> sampleListSong = [
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
  sampleSong,
];
