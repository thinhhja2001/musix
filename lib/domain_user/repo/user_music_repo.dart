import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import '../../global/repo/initial_repo.dart';
import '../../utils/utils.dart';
import '../models/models.dart';

class UserMusicRepo extends InitialRepo {
  FutureOr<UserMusicModel> getUserMusic({
    required String token,
  }) async {
    try {
      const url = '/music';

      var response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return UserMusicModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<UserMusicModel> getOtherUserMusic({
    required String token,
    required String username,
  }) async {
    try {
      final url = '/music/$username';

      var response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return UserMusicModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<SongsModel> favoriteSong({
    required String token,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
  }) async {
    try {
      const url = '/music/song/favorite';
      var data = {
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
      return SongsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<SongsModel> dislikeSong({
    required String token,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
  }) async {
    try {
      const url = '/music/song/dislike';
      var data = {
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
      return SongsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<PlaylistsModel> favoritePlaylist({
    required String token,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
    int? countSongs,
  }) async {
    try {
      const url = '/music/playlist/favorite';
      var data = {
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
      return PlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<PlaylistsModel> dislikePlaylist({
    required String token,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
    int? countSongs,
  }) async {
    try {
      const url = '/music/playlist/dislike';
      var data = {
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
      return PlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ArtistsModel> favoriteArtist({
    required String token,
    required String id,
    required String name,
    required String alias,
  }) async {
    try {
      const url = '/music/artist/favorite';
      var data = {
        "artist": {
          "id": id,
          "name": name,
          "alias": alias,
        }
      };
      debugPrint('$data');
      var response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return ArtistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<ArtistsModel> dislikeArtist({
    required String token,
    required String id,
    required String name,
    required String alias,
  }) async {
    try {
      const url = '/music/artist/dislike';
      var data = {
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
      return ArtistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<OwnPlaylistsModel> createOwnPlaylist({
    required String token,
    required String title,
    String? sortDescription,
  }) async {
    try {
      const url = '/music/ownPlaylist';
      var data = {
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
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<OwnPlaylistsModel> changeOwnPlaylist({
    required String token,
    required String playlistId,
    String? title,
    String? sortDescription,
  }) async {
    try {
      final url = '/music/ownPlaylist/$playlistId/changeProfile';
      var data = {};

      if (title != null) data["title"] = title;
      if (sortDescription != null) data['sortDescription'] = sortDescription;

      var response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<OwnPlaylistsModel> uploadThumbnailOwnPlaylist({
    required String token,
    required String playlistId,
    required List<int> thumbnail,
  }) async {
    try {
      final url = '/music/ownPlaylist/$playlistId/uploadThumbnail';

      var data = FormData.fromMap({
        'thumbnail': MultipartFile.fromBytes(
          thumbnail,
          filename: "image.png",
          contentType: MediaType.parse('image/jpeg'),
        ),
      });

      var response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headerMultiFormData(token: token),
        ),
      );
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<OwnPlaylistsModel> removeOwnPlaylist({
    required String token,
    required String playlistId,
  }) async {
    try {
      final url = "/music/ownPlaylist/$playlistId";

      var response = await dio.delete(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<OwnPlaylistsModel> uploadSongOwnPlaylist({
    required String token,
    required String playlistId,
    required String id,
    required String title,
    required String artistNames,
    required String? genreNames,
  }) async {
    try {
      final url = '/music/ownPlaylist/$playlistId/uploadSong';
      var data = {
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
      return OwnPlaylistsModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<UserRecordModel> getUserRecord({
    required String token,
  }) async {
    try {
      const url = '/music/record';

      var response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return UserRecordModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<String> saveSearchRecord({
    required String token,
    required String search,
  }) async {
    try {
      const url = '/music/search-song/history';
      var data = {
        "search": search,
      };

      var response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return response.data['data']['search'];
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<bool> deleteSearchRecord({
    required String token,
    String? search,
    bool isDeleteAll = false,
  }) async {
    try {
      const url = '/music/search-song/history';
      var data = {
        "search": search,
        "isDeleteAll": isDeleteAll,
      };

      var response = await dio.delete(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return true;
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<String> saveSongRecord({
    required String token,
    required String songId,
  }) async {
    try {
      const url = '/music/recent-song/history';
      var data = {
        "songId": songId,
      };

      var response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return response.data['data']['song'];
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  FutureOr<bool> deleteSongRecord({
    required String token,
    String? search,
    bool isDeleteAll = false,
  }) async {
    try {
      const url = '/music/recent-song/history';
      var data = {
        "search": search,
        "isDeleteAll": isDeleteAll,
      };

      var response = await dio.delete(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return true;
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }
}
