import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/exporter.dart';
import '../entities/entities.dart';

import '../../utils/utils.dart';
import '../utils/utils.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc({
    required SongsState initialState,
    required this.songRepo,
  }) : super(initialState) {
    on<GetSongsEvent>(_getSongs);
    on<RemoveSongEvent>(_removeSong);
    on<BackSongsEvent>(_backSong);
  }

  final SongInfoRepositoryImpl songRepo;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getSongs(
      GetSongsEvent event, Emitter<SongsState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SongsStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
        title: event.title,
      ));
      List<SongInfo> songs = [];
      for (String id in event.songIds) {
        final response = await songRepo.getInfo(id);
        final song = convertSongInfoModel(response);
        songs.add(song!);
      }

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SongsStatusKey.global.name,
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
            SongsStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(Exception("SongsLogic _getSongs error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SongsStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _removeSong(
      RemoveSongEvent event, Emitter<SongsState> emit) async {
    try {
      emit(state.copyWith(
        status: updateMapStatus(
          source: state.status,
          keys: [
            SongsStatusKey.global.name,
          ],
          status: [
            Status.loading,
          ],
        ),
      ));
      var songs = state.songs;
      songs?.removeWhere((element) => element.encodeId == event.id);

      emit(
        state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SongsStatusKey.global.name,
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
            SongsStatusKey.global.name,
          ],
          status: [
            Status.error,
          ],
        ),
      ));
      addError(Exception("SongsLogic _removeSong error"), StackTrace.current);
    }
    await Future.delayed(
      const Duration(milliseconds: 300),
    ).whenComplete(() => emit(state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [
              SongsStatusKey.global.name,
            ],
            status: [
              Status.idle,
            ],
          ),
        )));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _backSong(
      BackSongsEvent event, Emitter<SongsState> emit) async {
    emit(SongsState(
      status: updateMapStatus(
        source: state.status,
        keys: [
          SongsStatusKey.global.name,
        ],
        status: [
          Status.idle,
        ],
      ),
    ));
  }
}
