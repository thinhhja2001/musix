class Video {
  String songId;
  String thumbnailUrl;
  String url;
  String name;
  String artistName;

  Video({
    required this.thumbnailUrl,
    required this.songId,
    required this.url,
    required this.name,
    required this.artistName,
  });
}

Video sampleVideo = Video(
  songId: 'id',
  name: 'Nguoi nhu anh',
  artistName: 'Mai Tien Dung',
  thumbnailUrl:
      'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/cover/d/c/9/e/dc9e0327d6e99d57cdcd54981cb5989d.jpg?fs=MTY3NTmUsIC1NzI4OTYxN3x3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
  url:
      'https://vnno-pt-2-tf-mp3-s1-zmp3.zmdcdn.me/f0a1e85be91b0045590a/589361203805054074?authen=exp=1675930089~acl=/f0a1e85be91b0045590a/*~hmac=aad4f47b72ba13ef739bc3cb67bc836a&fs=MTY3NTmUsIC1NzI4OTY1Mnx3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
);
