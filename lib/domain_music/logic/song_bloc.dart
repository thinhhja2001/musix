import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_music/repository/repository.dart';
import 'package:musix/domain_music/services/musix_audio_handler.dart';
import 'package:musix/domain_music/utils/conver_model_entity/convert_song.dart';
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
    final songSource = convertSongSourceModel(response);
    musixAudioHandler.setSong(
      convertSongInfo(state.songInfo!)!,
      response,
    );
    musixAudioHandler.play();
    emit(
      state.copyWith(
          status: updateMapStatus(
              source: state.status,
              keys: [SongStatusKey.global.key],
              status: [Status.success]),
          songSource: songSource),
    );
  }
}
