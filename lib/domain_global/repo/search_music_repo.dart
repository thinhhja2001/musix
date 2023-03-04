import 'dart:async';

import 'package:musix/global/repo/initial_repo.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import '../models/model.dart';

class SearchMusicRepo extends InitialRepo {
  FutureOr<SearchAllModel> searchAll(String q) async {
    final response = await (await apiZingMP3).searchMusicByQuery(q);
    return SearchAllModel.fromJson(response);
  }

  FutureOr<SearchSongModel> searchSong(
    String q,
    int page,
    int count,
  ) async {
    final response = await (await apiZingMP3).searchMusicTypeByQuery(
      q: q,
      type: SearchType.song,
      page: page,
      count: count,
    );
    return SearchSongModel.fromJson(response);
  }

  FutureOr<SearchArtistModel> searchArtist(
    String q,
    int page,
    int count,
  ) async {
    final response = await (await apiZingMP3).searchMusicTypeByQuery(
      q: q,
      type: SearchType.artist,
      page: page,
      count: count,
    );
    return SearchArtistModel.fromJson(response);
  }

  FutureOr<SearchPlaylistModel> searchPlaylist(
    String q,
    int page,
    int count,
  ) async {
    final response = await (await apiZingMP3).searchMusicTypeByQuery(
      q: q,
      type: SearchType.playlist,
      page: page,
      count: count,
    );
    return SearchPlaylistModel.fromJson(response);
  }

  FutureOr<SearchVideoModel> searchVideo(
    String q,
    int page,
    int count,
  ) async {
    final response = await (await apiZingMP3).searchMusicTypeByQuery(
      q: q,
      type: SearchType.video,
      page: page,
      count: count,
    );
    return SearchVideoModel.fromJson(response);
  }
}
