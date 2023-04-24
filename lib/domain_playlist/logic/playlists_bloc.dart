import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/exporter.dart';
import '../entities/entities.dart';

import '../../utils/utils.dart';
import '../utils/utils.dart';

class PlaylistsBloc extends Bloc<PlaylistsEvent, PlaylistsState> {
  PlaylistsBloc({
    required PlaylistsState initialState,
    required this.playlistRepo,
  }) : super(initialState) {
    on<GetPlaylistsEvent>(_getPlaylists);
    on<RemovePlaylistEvent>(_removePlaylist);
    on<BackPlaylistsEvent>(_backPlaylist);
    on<PlaylistsResetEvent>(_resetPlaylist);
  }

  final PlaylistRepo playlistRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getPlaylists(
      GetPlaylistsEvent event, Emitter<PlaylistsState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistsStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
        title: event.title,
      ));
      List<MiniPlaylist> playlists = [];
      for (String id in event.playlistIds) {
        final response = await playlistRepo.getPlaylistById(id);
        final playlist = convertMiniPlaylistFromPlaylistModel(response.data);
        playlists.add(playlist!);
      }

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistsStatusKey.global.name,
            ],
            status: [
              Status.success,
            ],
          ),
          playlists: playlists,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistsStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(
          Exception("PlaylistsLogic _getPlaylists error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistsStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _removePlaylist(
      RemovePlaylistEvent event, Emitter<PlaylistsState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistsStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
      ));
      var playlists = state.playlists;
      playlists?.removeWhere((element) => element.encodeId == event.id);

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistsStatusKey.global.name,
            ],
            status: [
              Status.success,
            ],
          ),
          playlists: playlists,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistsStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(Exception("PlaylistsLogic _removePlaylist error"),
          StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistsStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _backPlaylist(
      BackPlaylistsEvent event, Emitter<PlaylistsState> emit) async {
    emit(PlaylistsState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          PlaylistsStatusKey.global.name,
        ],
        status: [
          Status.idle,
        ],
      ),
    ));
  }

  FutureOr<void> _resetPlaylist(
      PlaylistsResetEvent event, Emitter<PlaylistsState> emit) {
    emit(PlaylistsState(
      status: {
        PlaylistsStatusKey.global.name: Status.idle,
      },
    ));
  }
}
