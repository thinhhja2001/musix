class SongEvent {}

class SongGetInfoEvent implements SongEvent {
  final String id;

  SongGetInfoEvent(this.id);
}

class SongGetSourceEvent implements SongEvent {
  final String id;

  SongGetSourceEvent(this.id);
}
