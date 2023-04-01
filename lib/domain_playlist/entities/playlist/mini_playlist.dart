import 'package:equatable/equatable.dart';

class MiniPlaylist extends Equatable {
  final String? encodeId;
  final String? title;
  final String? artistsNames;
  final String? thumbnailM;
  final List<String>? artistAlias;
  final List<String>? genres;
  final int? countSong;

  const MiniPlaylist({
    this.encodeId,
    this.title,
    this.artistsNames,
    this.thumbnailM,
    this.artistAlias,
    this.genres,
    this.countSong,
  });

  MiniPlaylist copyWith({
    String? encodeId,
    String? title,
    String? artistsNames,
    String? thumbnailM,
    List<String>? artistAlias,
    List<String>? genres,
    int? countSong,
  }) {
    return MiniPlaylist(
      encodeId: encodeId ?? this.encodeId,
      title: title ?? this.title,
      artistsNames: artistsNames ?? this.artistsNames,
      thumbnailM: thumbnailM ?? this.thumbnailM,
      artistAlias: artistAlias ?? this.artistAlias,
      genres: genres ?? this.genres,
      countSong: countSong ?? this.countSong,
    );
  }

  @override
  List<Object?> get props => [
        encodeId,
        title,
        artistsNames,
        thumbnailM,
        artistAlias,
      ];

  @override
  bool? get stringify => true;
}

MiniPlaylist sampleMiniPlaylist = const MiniPlaylist(
  title: 'Classic',
  thumbnailM:
      r'https://photo-resize-zmp3.zmdcdn.me/w94_r1x1_jpeg/cover/d/c/9/e/dc9e0327d6e99d57cdcd54981cb5989d.jpg?fs=MTY3NTmUsIC1NzI4OTYxN3x3ZWJWNHwxODMdUngODAdUngMjE1LjmUsIC3',
  encodeId: r'ZWZCOZCF',
  artistsNames: r'Nhiều nghệ sĩ',
  genres: ['Classic'],
);
