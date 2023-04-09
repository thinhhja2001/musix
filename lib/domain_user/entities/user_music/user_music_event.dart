class UserMusicEvent {
  const UserMusicEvent();
}

class GetUserMusicEvent implements UserMusicEvent {
  const GetUserMusicEvent();
}

class FavoriteSongEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  const FavoriteSongEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
  });
}

class DislikeSongEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  const DislikeSongEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
  });
}

class FavoritePlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final int countSong;
  const FavoritePlaylistEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.countSong = 0,
  });
}

class DislikePlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final int countSong;
  const DislikePlaylistEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.countSong = 0,
  });
}

class FavoriteArtistEvent implements UserMusicEvent {
  final String id;
  final String name;
  final String alias;
  const FavoriteArtistEvent({
    required this.id,
    required this.name,
    required this.alias,
  });
}

class DislikeArtistEvent implements UserMusicEvent {
  final String id;
  final String name;
  final String alias;
  const DislikeArtistEvent({
    required this.id,
    required this.name,
    required this.alias,
  });
}

class CreateOwnPlaylistEvent implements UserMusicEvent {
  final String title;
  final String? sortDescription;
  const CreateOwnPlaylistEvent({
    required this.title,
    this.sortDescription,
  });
}

class ChangeOwnPlaylistEvent implements UserMusicEvent {
  final String title;
  final String? sortDescription;
  final String playlistId;
  const ChangeOwnPlaylistEvent({
    required this.title,
    required this.playlistId,
    this.sortDescription,
  });
}

class UploadThumbnailOwnPlaylistEvent implements UserMusicEvent {
  final List<int> thumbnail;
  final String playlistId;

  const UploadThumbnailOwnPlaylistEvent({
    required this.thumbnail,
    required this.playlistId,
  });
}

class RemoveOwnPlaylistEvent implements UserMusicEvent {
  final String playlistId;

  const RemoveOwnPlaylistEvent(this.playlistId);
}

class UploadSongOwnPlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final List<String> playlistIds;
  const UploadSongOwnPlaylistEvent({
    required this.playlistIds,
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
  });
}

class RemoveSongOwnPlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final String playlistId;
  const RemoveSongOwnPlaylistEvent({
    required this.playlistId,
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
  });
}
