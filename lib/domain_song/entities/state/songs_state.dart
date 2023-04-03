import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class SongsState extends Equatable {
  final Map<String, Status>? status;
  final List<SongInfo>? songs;
  final String? title;
  final String? thumbnail;

  const SongsState({
    this.status,
    this.songs,
    this.title,
    this.thumbnail,
  });

  SongsState copyWith({
    Map<String, Status>? status,
    List<SongInfo>? songs,
    String? title,
    String? thumbnail,
  }) {
    return SongsState(
      status: status ?? this.status,
      songs: songs ?? this.songs,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        songs?.length,
        title,
      ];

  @override
  bool? get stringify => true;
}
