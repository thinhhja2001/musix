class Song {
  final String id;
  final String name;
  late final String audioUrl;
  final String lyricUrl;
  final String artistName;
  final String artistLink;
  final String thumbnailUrl;
  Song(
      {required this.id,
      required this.name,
      required this.audioUrl,
      required this.lyricUrl,
      required this.artistName,
      required this.artistLink,
      required this.thumbnailUrl});

  static Song fromJson(Map<String, dynamic> songData) {
    return Song(
        id: songData['id'],
        name: songData['name'],
        audioUrl: songData['audioUrl'],
        lyricUrl: songData['lyricUrl'],
        artistName: songData['artistName'],
        artistLink: songData['artistLink'],
        thumbnailUrl: songData['thumbnailUrl']);
  }
}

Song sampleSong = Song(
    id: 'id',
    name: 'ANh nang cua anh',
    audioUrl:
        'https://vnso-zn-15-tf-mp3-s1-zmp3.zmdcdn.me/79cec7744e30a76efe21/561239208516760182?authen=exp=1676356051~acl=/79cec7744e30a76efe21/*~hmac=4f34d79765a12f9459d5e946c6a37d5e&fs=MTY3NjE4MzI1MTQ4OXx3ZWJWNHwxNzEdUngMjU1LjmUsIC4LjIzMg',
    lyricUrl:
        'https://static-zmp3.zmdcdn.me/lyrics/2017/01/12/2290252da79e87550a07e858db86579f_1075798557.lrc',
    artistName: 'Duc Phuc',
    artistLink: 'Duc Phuc',
    thumbnailUrl:
        'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/avatars/d/7/d7f34aa6b1112e4b605f6c6e7eccd162_1509437674.jpg?fs=MTY3NjE4MzI1MTQ4M3x3ZWJWNHwxNzEdUngMjU1LjmUsIC4LjIzMg');
