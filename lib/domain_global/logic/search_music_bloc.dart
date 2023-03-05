import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_hub/utils/convert_section/convert_section.dart';

import '../../domain_hub/entities/entities.dart';
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
    on<SearchMusicSongLoadMoreEvent>(_loadMoreSongs);
    on<SearchMusicPlaylistLoadMoreEvent>(_loadMorePlaylist);
    on<SearchMusicArtistLoadMoreEvent>(_loadMoreArtist);
  }

  final SearchMusicRepo repo;
  final _countPerPage = 18;

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

      final responseAll = await repo.searchAll(event.query);
      final responseSongs =
          await repo.searchSong(event.query, 1, _countPerPage);
      final responsePlaylists =
          await repo.searchPlaylist(event.query, 1, _countPerPage);
      final responseArtists =
          await repo.searchArtist(event.query, 1, _countPerPage);

      final sectionAll = convertSectionAllFromSearchAllModel(responseAll);

      final sectionSongs = convertSectionSongFromSearchSongModel(responseSongs);
      final sectionPlaylist =
          convertSectionPlaylistFromSearchPlaylistModel(responsePlaylists);
      final sectionArtist =
          convertSectionArtistFromSearchArtistModel(responseArtists);

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
        currentPage: updateCurrentPage(
          source: state.currentPage,
          keys: [
            MusicType.song,
            MusicType.playlist,
            MusicType.artist,
          ],
          pages: [
            sectionSongs.items?.length ?? 0,
            sectionPlaylist.items?.length ?? 0,
            sectionArtist.items?.length ?? 0,
          ],
        ),
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

  //----------------------------------------------------------------------------
  FutureOr<void> _loadMoreSongs(SearchMusicSongLoadMoreEvent event,
      Emitter<SearchMusicState> emit) async {
    if (state.songs?.items?.isEmpty == true) {
      return;
    }

    if (state.currentPage![MusicType.song]! >= state.songs!.total!) {
      return;
    }

    try {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.song.key,
            ],
            status: [
              Status.loading,
            ],
          ),
        ),
      );

      final page =
          (state.currentPage![MusicType.song]! / _countPerPage).floor();
      final response =
          await repo.searchSong(state.query!, page + 1, _countPerPage);
      SectionSong sectionSongs =
          convertSectionSongFromSearchSongModel(response);
      sectionSongs =
          combineSectionSong(state.songs!, sectionSongs, state.songs!.total!);
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.song.key,
          ],
          status: [
            Status.success,
          ],
        ),
        songs: sectionSongs,
        currentPage: updateCurrentPage(
          source: state.currentPage,
          keys: [
            MusicType.song,
          ],
          pages: [
            sectionSongs.items?.length ?? 0,
          ],
        ),
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.song.key,
            ],
            status: [
              Status.error,
            ],
          ),
        ),
      );
      addError(Exception("SearchMusicBloc _loadMoreSongs error $e"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.song.key,
          ],
          status: [
            Status.idle,
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _loadMoreArtist(SearchMusicArtistLoadMoreEvent event,
      Emitter<SearchMusicState> emit) async {
    if (state.artists?.items?.isEmpty == true) {
      return;
    }

    if (state.currentPage![MusicType.artist]! >= state.artists!.total!) {
      return;
    }

    try {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.artist.key,
            ],
            status: [
              Status.loading,
            ],
          ),
        ),
      );

      final page =
          (state.currentPage![MusicType.artist]! / _countPerPage).floor();
      final response =
          await repo.searchArtist(state.query!, page + 1, _countPerPage);
      SectionArtist sectionArtist =
          convertSectionArtistFromSearchArtistModel(response);
      sectionArtist = combineSectionArtist(
          state.artists!, sectionArtist, state.artists!.total!);
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.artist.key,
          ],
          status: [
            Status.success,
          ],
        ),
        artists: sectionArtist,
        currentPage: updateCurrentPage(
          source: state.currentPage,
          keys: [
            MusicType.artist,
          ],
          pages: [
            sectionArtist.items?.length ?? 0,
          ],
        ),
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.artist.key,
            ],
            status: [
              Status.error,
            ],
          ),
        ),
      );
      addError(Exception("SearchMusicBloc _loadMoreArtist error $e"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.artist.key,
          ],
          status: [
            Status.idle,
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _loadMorePlaylist(SearchMusicPlaylistLoadMoreEvent event,
      Emitter<SearchMusicState> emit) async {
    if (state.playlists?.items?.isEmpty == true) {
      return;
    }

    if (state.currentPage![MusicType.playlist]! >= state.playlists!.total!) {
      return;
    }

    try {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.playlist.key,
            ],
            status: [
              Status.loading,
            ],
          ),
        ),
      );

      final page =
          (state.currentPage![MusicType.playlist]! / _countPerPage).floor();
      final response =
          await repo.searchPlaylist(state.query!, page + 1, _countPerPage);
      SectionPlaylist sectionPlaylist =
          convertSectionPlaylistFromSearchPlaylistModel(response);
      sectionPlaylist = combineSectionPlaylist(
          state.playlists!, sectionPlaylist, state.playlists!.total!);
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.playlist.key,
          ],
          status: [
            Status.success,
          ],
        ),
        playlists: sectionPlaylist,
        currentPage: updateCurrentPage(
          source: state.currentPage,
          keys: [
            MusicType.playlist,
          ],
          pages: [
            sectionPlaylist.items?.length ?? 0,
          ],
        ),
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SearchMusicStatusKey.playlist.key,
            ],
            status: [
              Status.error,
            ],
          ),
        ),
      );
      addError(Exception("SearchMusicBloc _loadMorePlaylist error $e"),
          StackTrace.current);
    }

    emit(
      state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SearchMusicStatusKey.playlist.key,
          ],
          status: [
            Status.idle,
          ],
        ),
      ),
    );
  }
}

Map<MusicType, int> updateCurrentPage({
  required Map<MusicType, int>? source,
  required List<MusicType> keys,
  required List<int> pages,
}) {
  Map<MusicType, int> mapAdapter = {};
  for (int i = 0; i < keys.length; i++) {
    mapAdapter.addAll({keys[i]: pages[i]});
  }
  final result = Map<MusicType, int>.from(source ?? {})..addAll(mapAdapter);
  return result;
}
