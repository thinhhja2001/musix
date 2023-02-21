import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_album/entities/entities.dart';
import 'package:musix/domain_album/repo/playlist_repo.dart';
import 'package:musix/domain_album/utils/convert_model_entity/convert_playlist.dart';

import '../../utils/utils.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc({
    required PlaylistState initialState,
    required this.playlistRepo,
  }) : super(initialState) {
    on<PlaylistGetInfoEvent>(_getPlaylist);
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
          keys: [PlaylistStatusKey.global.key],
          status: [Status.loading],
        ),
      ));

      final response = await playlistRepo.getPlaylistById(event.id);
      final playlist = convertPlaylistModel(response.data);
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [PlaylistStatusKey.global.key],
            status: [Status.success],
          ),
          playlist: playlist,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [PlaylistStatusKey.global.key],
          status: [Status.error],
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
              keys: [PlaylistStatusKey.global.key],
              status: [Status.idle],
            ),
          ),
        ));
  }
}
