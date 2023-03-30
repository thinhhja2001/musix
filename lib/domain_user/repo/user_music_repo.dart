import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:musix/global/repo/initial_repo.dart';

import '../../utils/utils.dart';
import '../models/models.dart';

class UserMusicRepo extends InitialRepo {
  FutureOr<UserMusicModel> getUserMusic({
    required String token,
    required String username,
  }) async {
    const url = '/music';
    var data = {'username': username};

    var response = await dio.get(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return UserMusicModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<SongsModel> favoriteSong({
    required String token,
    required String username,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
  }) async {
    const url = '/music/song/favorite';
    var data = {
      "username": username,
      "song": {
        "id": id,
        "title": title,
        "artistNames": artistNames,
        "genreNames": genreNames,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return SongsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<SongsModel> dislikeSong({
    required String token,
    required String username,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
  }) async {
    const url = '/music/song/dislike';
    var data = {
      "username": username,
      "song": {
        "id": id,
        "title": title,
        "artistNames": artistNames,
        "genreNames": genreNames,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return SongsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<PlaylistsModel> favoritePlaylist({
    required String token,
    required String username,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
    int? countSongs,
  }) async {
    const url = '/music/playlist/favorite';
    var data = {
      "username": username,
      "playlist": {
        "id": id,
        "title": title,
        "artistNames": artistNames,
        "genreNames": genreNames,
        "countSongs": countSongs ?? 0,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return PlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<PlaylistsModel> dislikePlaylist({
    required String token,
    required String username,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
    int? countSongs,
  }) async {
    const url = '/music/playlist/dislike';
    var data = {
      "username": username,
      "playlist": {
        "id": id,
        "title": title,
        "artistNames": artistNames,
        "genreNames": genreNames,
        "countSongs": countSongs ?? 0,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return PlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<ArtistsModel> favoriteArtist({
    required String token,
    required String username,
    required String id,
    required String name,
    required String alias,
  }) async {
    const url = '/music/artist/favorite';
    var data = {
      "username": username,
      "artist": {
        "id": id,
        "name": name,
        "alias": alias,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return ArtistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<ArtistsModel> dislikeArtist({
    required String token,
    required String username,
    required String id,
    required String name,
    required String alias,
  }) async {
    const url = '/music/artist/dislike';
    var data = {
      "username": username,
      "artist": {
        "id": id,
        "name": name,
        "alias": alias,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return ArtistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<OwnPlaylistsModel> createOwnPlaylist({
    required String token,
    required String username,
    required String title,
    String? sortDescription,
  }) async {
    const url = '/music/playlist/create';
    var data = {
      "username": username,
      "title": title,
    };
    if (sortDescription != null) data['sortDescription'] = sortDescription;

    var response = await dio.post(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<OwnPlaylistsModel> changeOwnPlaylist({
    required String token,
    required String username,
    required String playlistId,
    String? title,
    String? sortDescription,
  }) async {
    const url = '/music/playlist/changeProfile';
    var data = {
      "username": username,
      "playlistId": playlistId,
    };

    if (title != null) data["title"] = title;
    if (sortDescription != null) data['sortDescription'] = sortDescription;

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<OwnPlaylistsModel> uploadThumbnailOwnPlaylist({
    required String token,
    required String username,
    required String playlistId,
    required List<int> thumbnail,
  }) async {
    const url = '/music/playlist/uploadThumbnail';

    var data = FormData.fromMap({
      'thumbnail': MultipartFile.fromBytes(
        thumbnail,
        filename: "image.png",
        contentType: MediaType.parse('image/jpeg'),
      ),
      'username': username,
      'playlistId': playlistId,
    });

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerMultiFormData(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<OwnPlaylistsModel> removeOwnPlaylist({
    required String token,
    required String username,
    required String playlistId,
  }) async {
    const url = "/music/playlist/remove";
    var data = {
      "username": username,
      "playlistId": playlistId,
    };

    var response = await dio.delete(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }

  FutureOr<OwnPlaylistsModel> uploadSongOwnPlaylist({
    required String token,
    required String username,
    required String playlistId,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
  }) async {
    const url = '/music/playlist/uploadSong';
    var data = {
      "username": username,
      "playlistId": playlistId,
      "song": {
        "id": id,
        "title": title,
        "artistNames": artistNames,
        "genreNames": genreNames,
      }
    };

    var response = await dio.put(
      url,
      data: data,
      options: Options(
        headers: headerApplicationJson(token: token),
      ),
    );

    if (response.statusCode == 200) {
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } else {
      throw ResponseException(
          statusCode: response.statusCode, message: response.data['msg']);
    }
  }
}
