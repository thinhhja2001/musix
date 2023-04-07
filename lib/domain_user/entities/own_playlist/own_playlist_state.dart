import 'package:musix/domain_song/entities/entities.dart';
import 'package:musix/utils/utils.dart';

class OwnPlaylistState {
  Map<String, Status>? status;
  String? id;
  String? title;
  String? description;
  String? thumbnail;
  List<SongInfo>? songs;

  OwnPlaylistState({
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
    );
  }
}
