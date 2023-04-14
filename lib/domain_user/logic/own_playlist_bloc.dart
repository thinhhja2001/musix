import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/exporter.dart';
import '../../domain_song/entities/entities.dart';
import '../../domain_song/utils/utils.dart';

import '../../utils/utils.dart';

class OwnPlaylistBloc extends Bloc<OwnPlaylistEvent, OwnPlaylistState> {
  OwnPlaylistBloc({
    required OwnPlaylistState initialState,
    required this.songRepo,
  }) : super(initialState) {
    on<GetOwnPlaylistEvent>(_getOwnPlaylist);
    on<UpdateOwnPlaylistEvent>(_updateOwnPlaylist);
    on<RemoveSongInOwnPlaylistEvent>(_removeSongOwnPlaylist);
  }

  final SongInfoRepositoryImpl songRepo;

  FutureOr<void> _getOwnPlaylist(
      GetOwnPlaylistEvent event, Emitter<OwnPlaylistState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            OwnPlaylistStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
        id: event.ownPlaylist.id,
        title: event.ownPlaylist.title,
        description: event.ownPlaylist.sortDescription,
        thumbnail: event.ownPlaylist.thumbnail,
      ));
      List<SongInfo> songs = [];
      for (String id in event.ownPlaylist.songs!) {
        final response = await songRepo.getInfo(id);
        final song = convertSongInfoModel(response);
        songs.add(song!);
      }
      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              OwnPlaylistStatusKey.global.name,
            ],
            status: [
              Status.success,
            ],
          ),
          songs: songs,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            OwnPlaylistStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(Exception("OwnPlaylistBloc _getOwnPlaylist error"),
          StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              OwnPlaylistStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  FutureOr<void> _updateOwnPlaylist(
      UpdateOwnPlaylistEvent event, Emitter<OwnPlaylistState> emit) async {
    emit(state.copyWith(
      status: updateMapStatus(
        source: state.status,
        keys: [
          OwnPlaylistStatusKey.global.name,
        ],
        status: [
          Status.success,
        ],
      ),
      title: event.title,
      description: event.sortDescription,
      thumbnail: event.thumbnail,
    ));

    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              OwnPlaylistStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  FutureOr<void> _removeSongOwnPlaylist(RemoveSongInOwnPlaylistEvent event,
      Emitter<OwnPlaylistState> emit) async {
    var songs = state.songs;
    songs?.removeWhere((element) => element.encodeId == event.id);
    emit(state.copyWith(
      status: updateMapStatus(
        source: state.status,
        keys: [
          OwnPlaylistStatusKey.global.name,
        ],
        status: [
          Status.success,
        ],
      ),
      songs: songs,
    ));

    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              OwnPlaylistStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }
}
