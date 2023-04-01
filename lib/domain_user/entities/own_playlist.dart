import 'package:equatable/equatable.dart';

class OwnPlaylist extends Equatable {
  final String? id;
  final String? title;
  final String? thumbnail;
  final String? releasedAt;
  final String? sortDescription;
  final List<String>? songs;
  final int? countSongs;

  const OwnPlaylist({
    this.id,
    this.title,
    this.thumbnail,
    this.sortDescription,
    this.countSongs,
    this.songs,
    this.releasedAt,
  });

  OwnPlaylist copyWith({
    String? id,
    String? title,
    String? thumbnail,
    String? releasedAt,
    String? sortDescription,
    List<String>? songs,
    int? countSongs,
  }) {
    return OwnPlaylist(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      releasedAt: releasedAt ?? this.releasedAt,
      sortDescription: sortDescription ?? this.sortDescription,
      songs: songs ?? this.songs,
      countSongs: countSongs ?? this.countSongs,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, thumbnail, sortDescription, songs, countSongs];

  @override
  bool? get stringify => true;
}
