import '../../../domain_hub/entities/entities.dart';

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
  final SectionPlaylist sectionPlaylist;
  const PlaylistGetListEvent(this.sectionPlaylist);
}

class PlaylistBackListEvent implements PlaylistEvent {
  const PlaylistBackListEvent();
}
