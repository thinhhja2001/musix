class UserMusicEvent {
  const UserMusicEvent();
}

class GetUserMusicEvent implements UserMusicEvent {
  const GetUserMusicEvent();
}

class CheckSongEvent implements UserMusicEvent {
  final bool isFavorite;
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  const CheckSongEvent({
    required this.isFavorite,
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
  });
}

class FavoriteSongEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final bool? isRemoveDislike;
  const FavoriteSongEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.isRemoveDislike,
  });
}

class DislikeSongEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final bool? isRemoveFavorite;
  const DislikeSongEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.isRemoveFavorite,
  });
}

class CheckPlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final int countSong;
  final bool isFavorite;
  const CheckPlaylistEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.countSong = 0,
    required this.isFavorite,
  });
}

class FavoritePlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final int countSong;
  final bool? isRemoveDislike;
  const FavoritePlaylistEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.countSong = 0,
    this.isRemoveDislike,
  });
}

class DislikePlaylistEvent implements UserMusicEvent {
  final String id;
  final String title;
  final List<String>? genreNames;
  final String artistNames;
  final int countSong;
  final bool? isRemoveFavorite;
  const DislikePlaylistEvent({
    required this.id,
    required this.title,
    this.genreNames,
    required this.artistNames,
    this.countSong = 0,
    this.isRemoveFavorite,
  });
}

class CheckArtistEvent implements UserMusicEvent {
  final String id;
  final String name;
  final String alias;
  final bool isFavorite;
  const CheckArtistEvent({
    required this.id,
    required this.name,
    required this.alias,
    required this.isFavorite,
  });
}

class FavoriteArtistEvent implements UserMusicEvent {
  final String id;
  final String name;
  final String alias;
  final bool? isRemoveDislike;
  const FavoriteArtistEvent({
    required this.id,
    required this.name,
    required this.alias,
    this.isRemoveDislike,
  });
}

class DislikeArtistEvent implements UserMusicEvent {
  final String id;
  final String name;
  final String alias;
  final bool? isRemoveFavorite;
  const DislikeArtistEvent({
    required this.id,
    required this.name,
    required this.alias,
    this.isRemoveFavorite,
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

class ResetUserMusicEvent implements UserMusicEvent {}
