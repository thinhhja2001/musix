import 'package:equatable/equatable.dart';

import 'own_playlist.dart';

class UserMusic extends Equatable {
  final List<String>? favoriteSongs;
  final List<String>? favoriteArtists;
  final List<String>? favoritePlaylists;
  final List<String>? dislikeSongs;
  final List<String>? dislikeArtists;
  final List<String>? dislikePlaylists;
  final List<OwnPlaylist>? ownPlaylists;

  const UserMusic({
    this.favoriteSongs,
    this.favoriteArtists,
    this.favoritePlaylists,
    this.dislikeSongs,
    this.dislikeArtists,
    this.dislikePlaylists,
    this.ownPlaylists,
  });

  UserMusic copyWith({
    List<String>? favoriteSongs,
    List<String>? favoriteArtists,
    List<String>? favoritePlaylists,
    List<String>? dislikeSongs,
    List<String>? dislikeArtists,
    List<String>? dislikePlaylists,
    List<OwnPlaylist>? ownPlaylists,
  }) {
    return UserMusic(
      favoriteArtists: favoriteArtists ?? this.favoriteArtists,
      favoritePlaylists: favoritePlaylists ?? this.favoritePlaylists,
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
      dislikeArtists: dislikeArtists ?? this.dislikeArtists,
      dislikePlaylists: dislikePlaylists ?? this.dislikePlaylists,
      dislikeSongs: dislikeSongs ?? this.dislikeSongs,
      ownPlaylists: ownPlaylists ?? this.ownPlaylists,
    );
  }

  @override
  List<Object?> get props => [
        favoriteSongs,
        favoritePlaylists,
        favoriteArtists,
        dislikeSongs,
        dislikePlaylists,
        dislikeArtists,
        ownPlaylists,
      ];

  @override
  bool? get stringify => true;
}
