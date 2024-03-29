class PlaylistEvent {
  const PlaylistEvent();
}

class PlaylistGetInfoEvent implements PlaylistEvent {
  final String id;
  const PlaylistGetInfoEvent(this.id);
}

class PlaylistBackInfoEvent implements PlaylistEvent {
  const PlaylistBackInfoEvent();
}

class PlaylistResetEvent implements PlaylistEvent {}
