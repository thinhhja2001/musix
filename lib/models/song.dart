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
