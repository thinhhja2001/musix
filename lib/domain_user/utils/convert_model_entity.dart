import '../entities/entities.dart';
import '../models/models.dart';

User convertUserModelToUser(UserModel userModel) {
  return User(
    id: userModel.id,
    username: userModel.username,
    email: userModel.email,
    enable: userModel.enabled,
    followings: userModel.followings,
    followers: userModel.followers,
    profile: convertProfileModelToProfile(userModel.profile),
  );
}

Profile convertProfileModelToProfile(ProfileModel profileModel) {
  return Profile(
    fullName: profileModel.fullName,
    avatarUrl: profileModel.avatarUri,
    phoneNumber: profileModel.phoneNumber,
    birthday: profileModel.birthday,
  );
}

OwnPlaylist convertOwnPlaylistModelToOwnPlaylist(
    OwnPlaylistModel ownPlaylistModel) {
  var songs = ownPlaylistModel.songs?.map((e) => e.id!).toList();
  return OwnPlaylist(
    id: ownPlaylistModel.id,
    title: ownPlaylistModel.title,
    thumbnail: ownPlaylistModel.thumbnail,
    sortDescription: ownPlaylistModel.sortDescription,
    countSongs: ownPlaylistModel.countSongs,
    songs: songs,
    releasedAt: ownPlaylistModel.releasedAt,
  );
}

UserMusic convertUserMusicModelToUserMusic(UserMusicModel userMusicModel) {
  var favoriteSongs =
      userMusicModel.music?.favoriteSongs?.map((e) => e.id!).toList();
  var favoritePlaylists =
      userMusicModel.music?.favoritePlaylists?.map((e) => e.id!).toList();
  var favoriteArtists =
      userMusicModel.music?.favoriteArtists?.map((e) => e.id!).toList();
  var dislikeSongs =
      userMusicModel.music?.dislikeSongs?.map((e) => e.id!).toList();
  var dislikeArtists =
      userMusicModel.music?.dislikeArtists?.map((e) => e.id!).toList();
  var dislikePlaylist =
      userMusicModel.music?.dislikePlaylist?.map((e) => e.id!).toList();
  var ownPlaylists = userMusicModel.music?.ownPlaylists
      ?.map((e) => convertOwnPlaylistModelToOwnPlaylist(e))
      .toList();
  return UserMusic(
    favoriteSongs: favoriteSongs,
    favoritePlaylists: favoritePlaylists,
    favoriteArtists: favoriteArtists,
    dislikeSongs: dislikeSongs,
    dislikePlaylists: dislikePlaylist,
    dislikeArtists: dislikeArtists,
    ownPlaylists: ownPlaylists,
  );
}

List<String> convertSongsModelToList(SongsModel songsModel) {
  var songs = songsModel.songs!.map((e) => e.id!).toList();
  return songs;
}

List<String> convertArtistsModelToList(ArtistsModel artistsModel) {
  var artists = artistsModel.artists!.map((e) => e.id!).toList();
  return artists;
}

List<String> convertPlaylistsModelToList(PlaylistsModel playlistsModel) {
  var playlists = playlistsModel.playlists!.map((e) => e.id!).toList();
  return playlists;
}

List<OwnPlaylist> convertOwnPlaylistsModelToList(
    OwnPlaylistsModel ownPlaylistsModel) {
  var ownPlaylists = ownPlaylistsModel.playlists!
      .map((e) => convertOwnPlaylistModelToOwnPlaylist(e))
      .toList();
  return ownPlaylists;
}
