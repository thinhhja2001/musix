import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final String? id;
  final String? name;
  final String? alias;
  final String? playlistId;
  final String? cover;
  final String? thumbnail;
  final String? biography;
  final String? sortBiography;
  final String? thumbnailM;
  final String? national;
  final String? birthday;
  final String? realname;

  @override
  List<Object?> get props => [
        id,
        name,
        alias,
        playlistId,
        cover,
        thumbnailM,
        biography,
        sortBiography,
        thumbnailM,
        national,
        birthday,
        realname,
      ];

  @override
  bool? get stringify => true;

  const Artist({
    this.id,
    this.name,
    this.alias,
    this.playlistId,
    this.cover,
    this.thumbnail,
    this.biography,
    this.sortBiography,
    this.thumbnailM,
    this.national,
    this.birthday,
    this.realname,
  });

  Artist copyWith({
    String? id,
    String? name,
    String? alias,
    String? playlistId,
    String? cover,
    String? thumbnail,
    String? biography,
    String? sortBiography,
    String? thumbnailM,
    String? national,
    String? birthday,
    String? realname,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      playlistId: playlistId ?? this.playlistId,
      cover: cover ?? this.cover,
      thumbnail: thumbnail ?? this.thumbnail,
      biography: biography ?? this.biography,
      sortBiography: sortBiography ?? this.sortBiography,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      national: national ?? this.national,
      birthday: birthday ?? this.birthday,
      realname: realname ?? this.realname,
    );
  }
}
