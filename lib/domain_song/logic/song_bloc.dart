import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../services/play_next_pre_handller.dart';

import '../../utils/utils.dart';
import '../entities/entities.dart';
import '../repository/repository.dart';
import '../services/musix_audio_handler.dart';
import '../utils/utils.dart';

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
    on<SongSetLoopModeEvent>(_setLoopMode);
    on<SongSetListSongInfoEvent>(_setListSongInfo);
    on<SongPlayNextSongEvent>(_playNextSong);
    on<SongPlayPreviousSongEvent>(_playPreviousSong);
    on<SongChangeShuffleModeEvent>(_changeShuffleMode);
    on<SongStartPlayingSectionEvent>(_startPlayingSection);
    on<SongResetEvent>(_resetEvent);
    _settingUpDurationStream();
    _setSongEndEvent();
  }
  final SongInfoRepositoryImpl songInfoRepositoryImpl;
  final SongSourceRepositoryImpl songSourceRepositoryImpl;
  final MusixAudioHandler musixAudioHandler;
  final PlayNextPreHandler _playNextPreHandler = PlayNextPreHandler([]);
  final int recommendSongCount = 10;
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
    DebugLogger().log('current song encode Id: ${songInfo?.encodeId}');
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

  //----------------------------------------------------------------------------
  FutureOr<void> _setLoopMode(SongSetLoopModeEvent event, Emitter emit) async {
    late LoopMode nextLoopMode;
    switch (state.loopMode) {
      case LoopMode.off:
        nextLoopMode = LoopMode.all;
        break;
      case LoopMode.all:
        nextLoopMode = LoopMode.one;
        break;
      case LoopMode.one:
        nextLoopMode = LoopMode.off;
        break;
      default:
    }
    emit(
      state.copyWith(
        loopMode: nextLoopMode,
      ),
    );
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _setSongEndEvent() async {
    musixAudioHandler.player.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        switch (state.loopMode) {
          case LoopMode.one:
            add(SongGetSourceEvent(state.songInfo?.encodeId ?? ""));
            break;
          default:
            add(SongPlayNextSongEvent());
            break;
        }
      }
    });
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _setListSongInfo(
      SongSetListSongInfoEvent event, Emitter emit) async {
    emit(state.copyWith(listSongInfo: event.listSongInfo));
    _playNextPreHandler.setListSongInfo(event.listSongInfo ?? []);
  }

  FutureOr<void> _startPlayingSection(
      SongStartPlayingSectionEvent event, Emitter emit) async {
    SongInfo starterSongInfo;
    if (event.staterSongInfo != null) {
      starterSongInfo = event.staterSongInfo!;
    } else {
      starterSongInfo = state.isShuffle
          ? _playNextPreHandler.getRandomSong()
          : _playNextPreHandler.listSongInfo.elementAt(0);
    }
    _playNextPreHandler.currentSongInfo = starterSongInfo;
    _playNextPreHandler.playedSongs.add(starterSongInfo);
    add(SongGetInfoEvent(starterSongInfo.encodeId!));
    add(SongGetSourceEvent(starterSongInfo.encodeId!));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _playNextSong(
      SongPlayNextSongEvent event, Emitter emit) async {
    if (_playNextPreHandler.listSongInfo.length == 1) {
      // Only recommend next song if there is no playlist is currently playing, meaning listSongInfo.length == 1
      List<String> nextSongRecommendation = await SongRecommendationRepo()
          .recommendNextSong(state.songInfo!.encodeId!, recommendSongCount);
      if (nextSongRecommendation.isEmpty) {
        /// If there is no recommend song, just seek the duration the the end
        add(SongOnSeekEvent(state.duration));
        add(SongPauseEvent());
        return;
      }
      // Play random song from the recommended song ids
      final nextSongEncodeId = nextSongRecommendation
          .elementAt(Random().nextInt(nextSongRecommendation.length));
      add(SongGetInfoEvent(nextSongEncodeId));
      add(SongGetSourceEvent(nextSongEncodeId));
      add(SongPlayEvent());
    } else {
      SongInfo? songInfo =
          _playNextPreHandler.getNextSong(state.isShuffle, state.loopMode);
      if (songInfo == null) {
        add(SongOnSeekEvent(state.duration));
        add(SongPauseEvent());
      } else {
        add(SongGetInfoEvent(songInfo.encodeId!));
        add(SongGetSourceEvent(songInfo.encodeId!));
        add(SongPlayEvent());
      }
    }
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _playPreviousSong(
      SongPlayPreviousSongEvent event, Emitter emit) async {
    if (_playNextPreHandler.playedSongs.length == 1) {
      add(SongOnSeekEvent(Duration.zero));
      return;
    }
    SongInfo songInfo = _playNextPreHandler.getPreviousSong();
    add(SongGetInfoEvent(songInfo.encodeId!));
    add(SongGetSourceEvent(songInfo.encodeId!));
    add(SongPlayEvent());
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _changeShuffleMode(
      SongChangeShuffleModeEvent event, Emitter emit) async {
    emit(state.copyWith(isShuffle: !state.isShuffle));
  }

  //----------------------------------------------------------------------------
  FutureOr<void> _resetEvent(SongResetEvent event, Emitter<SongState> emit) {
    emit(SongState(
      status: {
        SongStatusKey.global.key: Status.idle,
      },
    ));
  }
}
