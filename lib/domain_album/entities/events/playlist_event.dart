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

class PlaylistGetListEvent implements PlaylistEvent {
  final String hubId;
  const PlaylistGetListEvent(this.hubId);
}

class PlaylistBackListEvent implements PlaylistEvent {
  const PlaylistBackListEvent();
}
