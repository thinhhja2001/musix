import 'package:equatable/equatable.dart';

class MiniArtist extends Equatable {
  final String? id;
  final String? name;
  final String? alias;
  final String? thumbnailM;

  const MiniArtist({
    this.id,
    this.name,
    this.alias,
    this.thumbnailM,
  });

  MiniArtist copyWith({
    String? id,
    String? name,
    String? alias,
    String? thumbnailM,
  }) {
    return MiniArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      thumbnailM: thumbnailM ?? this.thumbnailM,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        alias,
        thumbnailM,
      ];

  @override
  bool? get stringify => true;
}

MiniArtist sampleMiniArtist = const MiniArtist(
  id: r'IWZ9ZWA7',
  name: r'Như Quỳnh',
  alias: r'Nhu-Quynh',
  thumbnailM:
      r'https://photo-resize-zmp3.zmdcdn.me/w600_r1x1_jpeg/avatars/d/c/4/6/dc46b91ae6e40a586283b03f31312baa.jpg',
);
