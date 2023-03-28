import '../models.dart';

class UserMusicModel {
  MusicModel? music;

  UserMusicModel({this.music});

  UserMusicModel.fromJson(Map<String, dynamic> json) {
    music = json['music'] != null ? MusicModel.fromJson(json['music']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (music != null) {
      data['music'] = music!.toJson();
    }
    return data;
  }
}

class MusicModel {
  String? id;
  UserModel? user;
  List<UserArtistModel>? favoriteArtists;
  List<UserArtistModel>? dislikeArtists;
  List<UserSongModel>? favoriteSongs;
  List<UserSongModel>? dislikeSongs;
  List<UserPlaylistModel>? favoritePlaylists;
  List<UserPlaylistModel>? dislikePlaylist;
  List<OwnPlaylistModel>? ownPlaylists;

  MusicModel(
      {this.id,
      this.user,
      this.favoriteArtists,
      this.dislikeArtists,
      this.favoriteSongs,
      this.dislikeSongs,
      this.favoritePlaylists,
      this.dislikePlaylist,
      this.ownPlaylists});

  MusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['favoriteArtists'] != null) {
      favoriteArtists = <UserArtistModel>[];
      json['favoriteArtists'].forEach((v) {
        favoriteArtists!.add(UserArtistModel.fromJson(v));
      });
    }
    if (json['dislikeArtists'] != null) {
      dislikeArtists = <UserArtistModel>[];
      json['dislikeArtists'].forEach((v) {
        dislikeArtists!.add(UserArtistModel.fromJson(v));
      });
    }
    if (json['favoriteSongs'] != null) {
      favoriteSongs = <UserSongModel>[];
      json['favoriteSongs'].forEach((v) {
        favoriteSongs!.add(UserSongModel.fromJson(v));
      });
    }
    if (json['dislikeSongs'] != null) {
      dislikeSongs = <UserSongModel>[];
      json['dislikeSongs'].forEach((v) {
        dislikeSongs!.add(UserSongModel.fromJson(v));
      });
    }
    if (json['favoritePlaylists'] != null) {
      favoritePlaylists = <UserPlaylistModel>[];
      json['favoritePlaylists'].forEach((v) {
        favoritePlaylists!.add(UserPlaylistModel.fromJson(v));
      });
    }
    if (json['dislikePlaylist'] != null) {
      dislikePlaylist = <UserPlaylistModel>[];
      json['dislikePlaylist'].forEach((v) {
        dislikePlaylist!.add(UserPlaylistModel.fromJson(v));
      });
    }
    if (json['ownPlaylists'] != null) {
      ownPlaylists = <OwnPlaylistModel>[];
      json['ownPlaylists'].forEach((v) {
        ownPlaylists!.add(OwnPlaylistModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (favoriteArtists != null) {
      data['favoriteArtists'] =
          favoriteArtists!.map((v) => v.toJson()).toList();
    }
    if (dislikeArtists != null) {
      data['dislikeArtists'] = dislikeArtists!.map((v) => v.toJson()).toList();
    }
    if (favoriteSongs != null) {
      data['favoriteSongs'] = favoriteSongs!.map((v) => v.toJson()).toList();
    }
    if (dislikeSongs != null) {
      data['dislikeSongs'] = dislikeSongs!.map((v) => v.toJson()).toList();
    }
    if (favoritePlaylists != null) {
      data['favoritePlaylists'] =
          favoritePlaylists!.map((v) => v.toJson()).toList();
    }
    if (dislikePlaylist != null) {
      data['dislikePlaylist'] =
          dislikePlaylist!.map((v) => v.toJson()).toList();
    }
    if (ownPlaylists != null) {
      data['ownPlaylists'] = ownPlaylists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
