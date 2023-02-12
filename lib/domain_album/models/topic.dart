class Topic {
  final String title;
  final String image;
  final List<Topic?> child;
  final List<String?> songs;

  Topic({
    required this.title,
    required this.image,
    required this.child,
    required this.songs,
  });
}

Topic sampleTopic = Topic(
  title: 'Classic',
  image:
      'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/cover/d/c/9/e/dc9e0327d6e99d57cdcd54981cb5989d.jpg?fs=MTY3NTmUsIC1NzI4OTYxN3x3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
  child: _topics,
  songs: _songs,
);

List<Topic> _topics = [
  sampleTopic,
  sampleTopic,
  sampleTopic,
];

List<String> _songs = [
  "Do I",
  "I Do",
];
