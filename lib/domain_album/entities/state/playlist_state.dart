import 'package:equatable/equatable.dart';
import '../entities.dart';
import '../../../utils/enum/enum_status.dart';

class PlaylistState extends Equatable {
  final Map<String, Status>? status;
  final Playlist? playlist;
  final List<Topic?>? topics;

  const PlaylistState({
    this.playlist,
    this.status,
    this.topics,
  });

  PlaylistState copyWith({
    Map<String, Status>? status,
    Playlist? playlist,
    List<Topic?>? topics,
  }) {
    return PlaylistState(
      status: status ?? this.status,
      playlist: playlist ?? this.playlist,
      topics: topics ?? this.topics,
    );
  }

  @override
  List<Object?> get props => [
        status,
        playlist,
        topics,
      ];

  @override
  bool? get stringify => true;
}
