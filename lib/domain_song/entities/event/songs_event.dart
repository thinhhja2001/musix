class SongsEvent {
  const SongsEvent();
}

class GetSongsEvent implements SongsEvent {
  final List<String> songIds;
  final String title;
  const GetSongsEvent({
    required this.songIds,
    required this.title,
  });
}

class RemoveSongEvent implements SongsEvent {
  final String id;
  const RemoveSongEvent(this.id);
}

class BackSongsEvent implements SongsEvent {
  const BackSongsEvent();
}
