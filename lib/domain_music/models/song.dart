import 'dart:convert';

class Song {
  Song({
    required this.encodeId,
    required this.title,
    required this.artistsNames,
    required this.thumbnailM,
    this.albumId,
    required this.artistsId,
    this.audioUrl,
    required this.genreIds,
    this.lyricUrl,
  });
  String encodeId;
  String title;
  String artistsNames;
  // Use thumbnailM instead of thumbnail because it will have higher resolution
  String thumbnailM;
  String? albumId;
  List artistsId;
  List genreIds;
  String? audioUrl;
  String? lyricUrl;

  factory Song.fromJson(
    Map<String, dynamic> songInfoJson,
    Map<String, dynamic> lyricJson,
    Map<String, dynamic> audioJson,
  ) {
    return Song(
      encodeId: songInfoJson["encodeId"],
      title: songInfoJson['title'],
      artistsNames: songInfoJson['artistsNames'],
      thumbnailM: songInfoJson['thumbnailM'],
      albumId: songInfoJson["album"] == null
          ? null
          : songInfoJson["album"]["encodeId"],
      //Convert List<dynamic> to List<String>
      genreIds:
          songInfoJson["genreIds"].map((genreId) => genreId as String).toList(),
      artistsId: songInfoJson["artists"]
          .map((artist) => artist["id"] as String)
          .toList(),
      audioUrl: audioJson["320"] ?? audioJson["128"],
      lyricUrl: lyricJson["file"],
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
        "audioUrl": audioUrl,
        "lyricUrl": lyricUrl,
      };
}

Song sampleSong = Song(
  encodeId: "ZW68AD67",
  title: "Rap God",
  artistsNames: "Eminem",
  genreIds: ["IWZ9Z08O", "IWZ9Z09B"],
  thumbnailM:
      "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/1/d/0/5/1d057df84228de726b09218407021004.jpg",
  artistsId: ["IWZ9ZOOF"],
  albumId: "ZWZAFD88",
  audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
  lyricUrl:
      "https://static-zmp3.zmdcdn.me/lyrics/2017/10/16/a9964ecbabb05f324ec4588c380d1d8d_1074748647.lrc",
);

List<Song> sampleListSong = [
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
