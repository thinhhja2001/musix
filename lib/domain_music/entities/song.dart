import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String? encodeId;
  final String? title;
  final String? alias;
  final bool? isOffical;
  final String? username;
  final String? artistsNames;
  final List<String>? artistIds;
  final String? thumbnailM;
  final String? thumbnail;
  final int? duration;
  final int? releaseDate;
  final List<String>? genreIds;
  final int? radioId;
  final bool? hasLyric;
  final String? mvlink;

  const Song({
    this.encodeId,
    this.title,
    this.alias,
    this.isOffical,
    this.username,
    this.artistsNames,
    this.artistIds,
    this.thumbnailM,
    this.thumbnail,
    this.duration,
    this.releaseDate,
    this.genreIds,
    this.radioId,
    this.hasLyric,
    this.mvlink,
  });

  Song copyWith({
    String? encodeId,
    String? title,
    String? alias,
    bool? isOffical,
    String? username,
    String? artistsNames,
    List<String>? artistIds,
    String? thumbnailM,
    String? thumbnail,
    int? duration,
    int? releaseDate,
    List<String>? genreIds,
    int? radioId,
    bool? hasLyric,
    String? mvlink,
  }) {
    return Song(
      encodeId: encodeId ?? this.encodeId,
      title: title ?? this.title,
      alias: alias ?? this.alias,
      isOffical: isOffical ?? this.isOffical,
      username: username ?? this.username,
      artistsNames: artistsNames ?? this.artistsNames,
      artistIds: artistIds ?? this.artistIds,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      radioId: radioId ?? this.radioId,
      hasLyric: hasLyric ?? this.hasLyric,
      mvlink: mvlink ?? this.mvlink,
    );
  }

  @override
  List<Object?> get props => [
        encodeId,
        title,
        alias,
        isOffical,
        username,
        artistsNames,
        artistIds,
        thumbnailM,
        thumbnail,
        duration,
        releaseDate,
        genreIds,
        radioId,
        hasLyric,
        mvlink,
      ];

  @override
  bool? get stringify => true;
}
