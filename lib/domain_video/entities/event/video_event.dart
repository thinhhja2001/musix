class VideoEvent {}

class VideoGetVideoShortEvent implements VideoEvent {
  final String id;

  VideoGetVideoShortEvent(this.id);
}

class VideoGetVideoDetailEvent implements VideoEvent {
  final String id;

  VideoGetVideoDetailEvent(this.id);
}

class VideoBackEvent implements VideoEvent {}
