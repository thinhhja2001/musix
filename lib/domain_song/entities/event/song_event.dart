import '../entities.dart';

class SongEvent {}

class SongGetInfoEvent implements SongEvent {
  final String id;

  SongGetInfoEvent(this.id);
}

class SongGetSourceEvent implements SongEvent {
  final String id;

  SongGetSourceEvent(this.id);
}

class SongPlayEvent implements SongEvent {}

class SongPauseEvent implements SongEvent {}

class SongUpdatePositionEvent implements SongEvent {
  final Duration position;

  SongUpdatePositionEvent(this.position);
}

class SongUpdateDurationEvent implements SongEvent {
  final Duration? duration;

  SongUpdateDurationEvent(this.duration);
}

class SongOnSeekEvent implements SongEvent {
  final Duration position;

  SongOnSeekEvent(this.position);
}

class SongSetLoopModeEvent implements SongEvent {}

class SongSetListSongInfoEvent implements SongEvent {
  final List<SongInfo>? listSongInfo;
  SongSetListSongInfoEvent(this.listSongInfo);
}

class SongStartPlayingSectionEvent implements SongEvent {
  final int? index;

  SongStartPlayingSectionEvent(this.index);
}

class SongPlayNextSongEvent implements SongEvent {}

class SongPlayPreviousSongEvent implements SongEvent {}

class SongChangeShuffleModeEvent implements SongEvent {}
