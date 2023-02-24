import 'package:equatable/equatable.dart';
import 'package:musix/domain_song/entities/song_info.dart';
import 'package:musix/domain_song/entities/song_source.dart';
import 'package:musix/utils/utils.dart';

class SongState extends Equatable {
  final Map<String, Status>? status;
  final SongInfo? songInfo;
  final SongSource? songSource;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  const SongState({
    this.status,
    this.songInfo,
    this.songSource,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  SongState copyWith({
    Map<String, Status>? status,
    SongInfo? songInfo,
    SongSource? songSource,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) =>
      SongState(
        status: status ?? this.status,
        songInfo: songInfo ?? this.songInfo,
        songSource: songSource ?? this.songSource,
        isPlaying: isPlaying ?? this.isPlaying,
        position: position ?? this.position,
        duration: duration ?? this.duration,
      );
  @override
  List<Object?> get props => [
        status,
        songInfo,
        songSource,
        isPlaying,
        position,
        duration,
      ];

  @override
  bool? get stringify => true;
}
