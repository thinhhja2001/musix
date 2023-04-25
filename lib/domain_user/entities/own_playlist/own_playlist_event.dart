import '../entities.dart';

abstract class OwnPlaylistEvent {
  const OwnPlaylistEvent();
}

class GetOwnPlaylistEvent implements OwnPlaylistEvent {
  final OwnPlaylist ownPlaylist;
  const GetOwnPlaylistEvent(this.ownPlaylist);
}

class UpdateOwnPlaylistEvent implements OwnPlaylistEvent {
  final String? title;
  final String? thumbnail;
  final String? sortDescription;
  const UpdateOwnPlaylistEvent({
    this.title,
    this.thumbnail,
    this.sortDescription,
  });
}

class RemoveSongInOwnPlaylistEvent implements OwnPlaylistEvent {
  final String id;
  const RemoveSongInOwnPlaylistEvent(this.id);
}

class ResetOwnPlaylistEvent implements OwnPlaylistEvent {}
