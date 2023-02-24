import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_song/repository/repository.dart';
import 'package:musix/domain_song/services/musix_audio_handler.dart';
import 'package:musix/domain_song/utils/conver_model_entity/convert_song.dart';
import 'package:musix/utils/debug/logger.dart';
import 'package:musix/utils/utils.dart';

import '../entities/entities.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongBloc({
    required this.musixAudioHandler,
    required SongState initialState,
    required this.songInfoRepositoryImpl,
    required this.songSourceRepositoryImpl,
  }) : super(initialState) {
    on<SongGetInfoEvent>(_getSongInfo);
    on<SongGetSourceEvent>(_getSourceInfo);
    on<SongPlayEvent>(_playSong);
    on<SongPauseEvent>(_pauseSong);
    on<SongUpdatePositionEvent>(_updatePosition);
    on<SongUpdateDurationEvent>(_updateDuration);
    on<SongOnSeekEvent>(_seekToPosition);
    _settingUpDurationStream();
  }
  final SongInfoRepositoryImpl songInfoRepositoryImpl;
  final SongSourceRepositoryImpl songSourceRepositoryImpl;
  final MusixAudioHandler musixAudioHandler;

  //----------------------------------------------------------------------------
  @override
  void onError(Object error, StackTrace stackTrace) {
    DebugLogger debugLogger = DebugLogger();
    debugLogger.log('$error\n $stackTrace');
    super.onError(error, stackTrace);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getSongInfo(SongGetInfoEvent event, Emitter emit) async {
    emit(state.copyWith(
      status: updateMapStatus(
        source: state.status,
        keys: [SongStatusKey.global.key],
        status: [
          Status.loading,
        ],
      ),
    ));

    final response = await songInfoRepositoryImpl.getInfo(event.id);
    final songInfo = convertSongInfoModel(response);
    print('current song encode Id: ${songInfo?.encodeId}');
    emit(
      state.copyWith(
          status: updateMapStatus(
            source: state.status,
            keys: [SongStatusKey.global.key],
            status: [Status.success],
          ),
          songInfo: songInfo),
    );
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _getSourceInfo(SongGetSourceEvent event, Emitter emit) async {
    emit(state.copyWith(
        status: updateMapStatus(
            source: state.status,
            keys: [SongStatusKey.global.key],
            status: [Status.loading])));
    final response = await songSourceRepositoryImpl.getInfo(event.id);
    musixAudioHandler.setSong(
      convertSongInfo(state.songInfo!)!,
      response,
    );
    add(SongPlayEvent());
    emit(
      state.copyWith(
          status: updateMapStatus(
              source: state.status,
              keys: [SongStatusKey.global.key],
              status: [Status.success]),
          songSource: convertSongSourceModel(response)),
    );
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _playSong(SongPlayEvent event, Emitter emit) async {
    emit(
      state.copyWith(isPlaying: true),
    );
    await musixAudioHandler.play();
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _pauseSong(SongPauseEvent event, Emitter emit) async {
    emit(
      state.copyWith(isPlaying: false),
    );
    await musixAudioHandler.pause();
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _updatePosition(
      SongUpdatePositionEvent event, Emitter emit) async {
    emit(state.copyWith(position: event.position));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _updateDuration(
      SongUpdateDurationEvent event, Emitter emit) async {
    emit(state.copyWith(duration: event.duration));
  }

  FutureOr<void> _seekToPosition(SongOnSeekEvent event, Emitter emit) async {
    musixAudioHandler.seek(event.position);
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _settingUpDurationStream() {
    musixAudioHandler.player.positionStream.listen((position) {
      add(SongUpdatePositionEvent(position));
    });
    musixAudioHandler.player.durationStream.listen((duration) {
      add(SongUpdateDurationEvent(duration));
    });
  }
}
