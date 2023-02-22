class SongInfo {
  SongInfo({
    required this.encodeId,
    required this.title,
    required this.artistsNames,
    required this.thumbnailM,
    required this.genreIds,
    this.albumId,
    this.artistsId,
  });
  String encodeId;
  String title;
  String artistsNames;
  // Use thumbnailM instead of thumbnail because it will have higher resolution
  String thumbnailM;
  List<String> genreIds;
  String? albumId;
  List<String>? artistsId;

  factory SongInfo.fromJson(
    Map<String, dynamic> songInfoJson,
  ) {
    return SongInfo(
      encodeId: songInfoJson["encodeId"],
      title: songInfoJson['title'],
      artistsNames: songInfoJson['artistsNames'],
      thumbnailM: songInfoJson['thumbnailM'],
      albumId: songInfoJson["album"]?["encodeId"],
      genreIds: songInfoJson["genreIds"]
          .map((genreId) => genreId as String)
          .toList()
          .cast<String>(),
      artistsId: songInfoJson["artists"]
          ?.map((artist) => artist["id"] as String)
          .toList()
          .cast<String>(),
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

SongInfo sampleSong = SongInfo(
  encodeId: "ZW68AD67",
  title: "Rap God",
  artistsNames: "Eminem",
  genreIds: ["IWZ9Z08O", "IWZ9Z09B"],
  thumbnailM:
      "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/d/0/5/1d057df84228de726b09218407021004.jpg",
  artistsId: ["IWZ9ZOOF"],
  albumId: "ZWZAFD88",
);

List<SongInfo> sampleListSong = [
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
