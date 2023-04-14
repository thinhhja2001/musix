import 'package:equatable/equatable.dart';
import '../../../domain_song/entities/entities.dart';
import '../../../utils/utils.dart';

class OwnPlaylistState extends Equatable {
  final Map<String, Status>? status;
  final String? id;
  final String? title;
  final String? description;
  final String? thumbnail;
  final List<SongInfo>? songs;

  const OwnPlaylistState({
    this.status,
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.songs,
  });

  OwnPlaylistState copyWith({
    Map<String, Status>? status,
    String? id,
    String? title,
    String? description,
    String? thumbnail,
    List<SongInfo>? songs,
  }) {
    return OwnPlaylistState(
      status: status ?? this.status,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => [
        status,
        id,
        title,
        description,
        thumbnail,
        songs?.length,
      ];

  @override
  bool? get stringify => true;
}
