import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';
import '../entities/entities.dart';
import '../repo/repo.dart';
import '../utils/convert_search_music/convert_search_music.dart';

class SearchMusicBloc extends Bloc<SearchMusicEvent, SearchMusicState> {
  SearchMusicBloc({
    required SearchMusicState initialState,
    required this.repo,
  }) : super(initialState) {
    on<SearchMusicQueryEvent>(_searchAllByQuery);
  }

  final SearchMusicRepo repo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _searchAllByQuery(
      SearchMusicQueryEvent event, Emitter<SearchMusicState> emit) async {
    try {
      if (state.query == event.query) {
        return;
      }
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.global.key,
            ],
            status: [
              Status.loading,
            ],
          ),
          query: event.query,
        ),
      );
      DebugLogger().log(event.query);
      final responseAll = await repo.searchAll(event.query);
      final responseSongs = await repo.searchSong(event.query, 1, 18);
      final responsePlaylists = await repo.searchPlaylist(event.query, 1, 18);
      final responseArtists = await repo.searchArtist(event.query, 1, 18);
      final sectionAll = convertSectionAllFromSearchAllModel(responseAll);
      final sectionSongs = convertSectionSongFromSearchSongModel(responseSongs);
      final sectionPlaylist =
          convertSectionPlaylistFromSearchPlaylistModel(responsePlaylists);
      final sectionArtist =
          convertSectionArtistFromSearchArtistModel(responseArtists);
      DebugLogger().log(
          '${sectionAll.items?.length} - ${sectionSongs.items?.length} - ${sectionArtist.items?.length} - ${sectionPlaylist.items?.length}');
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.global.key,
          ],
          status: [
            Status.success,
          ],
        ),
        all: sectionAll,
        songs: sectionSongs,
        playlists: sectionPlaylist,
        artists: sectionArtist,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.global.key,
            ],
            status: [
              Status.error,
            ],
          ),
        ),
      );
      addError(Exception("SearchMusicBloc _searchAllByQuery error $e"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.global.key,
          ],
          status: [
            Status.idle,
          ],
        ),
      ),
    );
  }
}
