import 'package:equatable/equatable.dart';

import '../../../domain_hub/entities/entities.dart';

class Artist extends Equatable {
  final String? id;
  final String? name;
  final String? alias;
  final String? playlistId;
  final String? cover;
  final String? biography;
  final String? sortBiography;
  final String? thumbnailM;
  final String? national;
  final String? birthday;
  final String? realname;
  final List<SectionPlaylist>? sectionPlaylist;
  final SectionSong? songs;

  @override
  List<Object?> get props => [
        id,
        name,
        alias,
        playlistId,
        cover,
        biography,
        sortBiography,
        thumbnailM,
        national,
        birthday,
        realname,
        sectionPlaylist,
        songs,
      ];

  @override
  bool? get stringify => true;

  const Artist({
    this.id,
    this.name,
    this.alias,
    this.playlistId,
    this.cover,
    this.biography,
    this.sortBiography,
    this.thumbnailM,
    this.national,
    this.birthday,
    this.realname,
    this.sectionPlaylist,
    this.songs,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? alias,
    String? playlistId,
    String? cover,
    String? biography,
    String? sortBiography,
    String? thumbnailM,
    String? national,
    String? birthday,
    String? realname,
    List<SectionPlaylist>? sectionPlaylist,
    SectionSong? songs,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      playlistId: playlistId ?? this.playlistId,
      cover: cover ?? this.cover,
      biography: biography ?? this.biography,
      sortBiography: sortBiography ?? this.sortBiography,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      national: national ?? this.national,
      birthday: birthday ?? this.birthday,
      realname: realname ?? this.realname,
      sectionPlaylist: sectionPlaylist ?? this.sectionPlaylist,
      songs: songs ?? this.songs,
    );
  }
}
