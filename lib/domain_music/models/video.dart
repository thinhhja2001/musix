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
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
);

List<Video> sampleVideoList = [
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
  sampleVideo,
];
