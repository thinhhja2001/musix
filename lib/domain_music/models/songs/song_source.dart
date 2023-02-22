class SongSource {
  String? audioUrl;
  String? lyricUrl;

  SongSource({this.audioUrl, this.lyricUrl});

  factory SongSource.fromJson(
      Map<String, dynamic> audioJson, Map<String, dynamic> lyricJson) {
    // To get the best audio version available
    // Audio version could be 128kb or 320kb
    final audioUrl = audioJson[audioJson.keys.last];
    return SongSource(
      audioUrl: audioUrl,
      lyricUrl: lyricJson["file"],
    );
  }
  Map<String, dynamic> toJson() => {
        "audioUrl": audioUrl,
        "lyricUrl": lyricUrl,
      };
}

final sampleSource = SongSource(
  audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
  lyricUrl:
      "https://static-zmp3.zmdcdn.me/lyrics/2017/10/16/a9964ecbabb05f324ec4588c380d1d8d_1074748647.lrc",
);
