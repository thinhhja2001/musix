import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

import '../../../utils/utils.dart';
import '../song_info.dart';
import '../song_source.dart';

class SongState extends Equatable {
  final Map<String, Status>? status;
  final SongInfo? songInfo;
  final List<SongInfo>? listSongInfo;
  final SongSource? songSource;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final LoopMode loopMode;
  final bool isShuffle;
  const SongState({
    this.status,
    this.songInfo,
    this.songSource,
    this.listSongInfo,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.loopMode = LoopMode.off,
    this.isShuffle = false,
  });

  SongState copyWith({
    Map<String, Status>? status,
    SongInfo? songInfo,
    SongSource? songSource,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    LoopMode? loopMode,
    List<SongInfo>? listSongInfo,
    bool? isShuffle,
  }) =>
      SongState(
        status: status ?? this.status,
        songInfo: songInfo ?? this.songInfo,
        songSource: songSource ?? this.songSource,
        isPlaying: isPlaying ?? this.isPlaying,
        position: position ?? this.position,
        duration: duration ?? this.duration,
        listSongInfo: listSongInfo ?? this.listSongInfo,
        loopMode: loopMode ?? this.loopMode,
        isShuffle: isShuffle ?? this.isShuffle,
      );
  @override
  List<Object?> get props => [
        status,
        songInfo,
        songSource,
        isPlaying,
        position,
        duration,
        loopMode,
        listSongInfo,
        isShuffle,
      ];

  @override
  bool? get stringify => true;
}
