import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/exporter/repo_exporter.dart';
import '../../utils/utils.dart';
import '../entities/entities.dart';
import '../utils/convert_playlist/convert_playlist.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc({
    required PlaylistState initialState,
    required this.playlistRepo,
  }) : super(initialState) {
    on<PlaylistGetInfoEvent>(_getPlaylist);
    on<PlaylistBackInfoEvent>(_backInfo);
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
  FutureOr<void> _getPlaylist(
      PlaylistGetInfoEvent event, Emitter<PlaylistState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistStatusKey.global.key,
            PlaylistStatusKey.info.key,
          ],
          status: [
            Status.loading,
            Status.loading,
          ],
        ),
      ));

      final response = await playlistRepo.getPlaylistById(event.id);
      debugPrint('${response.data}');
      final playlist = convertPlaylistModel(response.data);
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              PlaylistStatusKey.global.key,
              PlaylistStatusKey.info.key,
            ],
            status: [
              Status.idle,
              Status.success,
            ],
          ),
          playlist: playlist,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            PlaylistStatusKey.global.key,
            PlaylistStatusKey.info.key,
          ],
          status: [
            Status.idle,
            Status.error,
          ],
        ),
      ));
      addError(
          Exception("PlaylistLogic _getPlaylist error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(
          state.copyWith(
            status: updateMapStatus(
              source: state.status,
              keys: [
                PlaylistStatusKey.global.key,
                PlaylistStatusKey.info.key,
              ],
              status: [
                Status.idle,
                Status.idle,
              ],
            ),
          ),
        ));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _backInfo(
      PlaylistBackInfoEvent event, Emitter<PlaylistState> emit) async {
    emit(PlaylistState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          PlaylistStatusKey.global.key,
          PlaylistStatusKey.playlists.key,
        ],
        status: [
          Status.idle,
          Status.idle,
        ],
      ),
    ));
  }
}
