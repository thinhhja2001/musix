import 'package:equatable/equatable.dart';

import '../../../domain_playlist/entities/entities.dart';

class NewReleasePlaylist extends Equatable {
  final String title;
  final List<Playlist?> playlists;

  const NewReleasePlaylist({
    required this.title,
    required this.playlists,
  });

  NewReleasePlaylist copyWith({
    String? title,
    List<Playlist?>? playlists,
  }) {
    return NewReleasePlaylist(
      title: title ?? this.title,
      playlists: playlists ?? this.playlists,
    );
  }

  @override
  List<Object?> get props => [
        title,
        playlists,
      ];

  @override
  bool? get stringify => true;
}
