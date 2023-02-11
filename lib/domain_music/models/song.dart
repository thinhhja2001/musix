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
  name: 'Nguoi nhu anh',
  audioUrl:
      'https://vnno-pt-2-tf-mp3-s1-zmp3.zmdcdn.me/f0a1e85be91b0045590a/589361203805054074?authen=exp=1675930089~acl=/f0a1e85be91b0045590a/*~hmac=aad4f47b72ba13ef739bc3cb67bc836a&fs=MTY3NTmUsIC1NzI4OTY1Mnx3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
  lyricUrl:
      'https://static-zmp3.zmdcdn.me/lyrics/d/f/9/9/df99fc219774148ef4719acabfd67dd4.lrc',
  artistName: 'Mai Tien Dung',
  artistLink: 'Mai tien dung',
  thumbnailUrl:
      'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/cover/d/c/9/e/dc9e0327d6e99d57cdcd54981cb5989d.jpg?fs=MTY3NTmUsIC1NzI4OTYxN3x3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
);
