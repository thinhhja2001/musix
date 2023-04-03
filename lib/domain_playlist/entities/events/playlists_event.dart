class PlaylistsEvent {
  const PlaylistsEvent();
}

class GetPlaylistsEvent implements PlaylistsEvent {
  final List<String> playlistIds;
  final String title;
  const GetPlaylistsEvent({
    required this.playlistIds,
    required this.title,
  });
}

class RemovePlaylistEvent implements PlaylistsEvent {
  final String id;
  const RemovePlaylistEvent(this.id);
}

class BackPlaylistsEvent implements PlaylistsEvent {
  const BackPlaylistsEvent();
}
