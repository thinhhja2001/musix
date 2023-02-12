class Album {
  String id;
  String albumName;
  String artistName;
  String thumbnailUrl;

  Album({
    required this.id,
    required this.albumName,
    required this.artistName,
    required this.thumbnailUrl,
  });
}

Album sampleAlbum = Album(
  id: 'id',
  albumName: 'Nhung tac pham hay cua Mai Tien Dung',
  artistName: 'Mai Tien Dung',
  thumbnailUrl:
      'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/cover/d/c/9/e/dc9e0327d6e99d57cdcd54981cb5989d.jpg?fs=MTY3NTmUsIC1NzI4OTYxN3x3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
);

List<Album> sampleListAlbum = [
  sampleAlbum,
  sampleAlbum,
  sampleAlbum,
  sampleAlbum,
];
