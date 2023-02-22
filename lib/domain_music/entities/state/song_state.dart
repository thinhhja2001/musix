import 'package:equatable/equatable.dart';
import 'package:musix/domain_music/entities/song_info.dart';
import 'package:musix/domain_music/entities/song_source.dart';
import 'package:musix/utils/utils.dart';

class SongState extends Equatable {
  final Map<String, Status>? status;
  final SongInfo? songInfo;
  final SongSource? songSource;

  const SongState({this.status, this.songInfo, this.songSource});

  SongState copyWith(
          {Map<String, Status>? status,
          SongInfo? songInfo,
          SongSource? songSource}) =>
      SongState(
        status: status ?? status,
        songInfo: songInfo ?? songInfo,
        songSource: songSource ?? songSource,
      );
  @override
  List<Object?> get props => [
        status,
        songInfo,
        songSource,
      ];

  @override
  bool? get stringify => true;
}
