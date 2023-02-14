class Artist {
  String id;
  String name;
  String imageUrl;

  Artist({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

Artist sampleArtist = Artist(
  id: 'id',
  name: 'Mai Tien Dung',
  imageUrl:
      'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/cover/d/c/9/e/dc9e0327d6e99d57cdcd54981cb5989d.jpg?fs=MTY3NTmUsIC1NzI4OTYxN3x3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
);

List<Artist> sampleArtistList = [
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
  sampleArtist,
];
