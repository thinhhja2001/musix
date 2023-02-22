class PlaylistEvent {
  const PlaylistEvent();
}

class PlaylistGetInfoEvent implements PlaylistEvent {
  final String id;
  const PlaylistGetInfoEvent(this.id);
}

class BackEvent implements PlaylistEvent {
  const BackEvent();
}