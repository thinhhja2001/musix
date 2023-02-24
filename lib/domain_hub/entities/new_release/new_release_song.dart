import 'package:equatable/equatable.dart';

import '../../../domain_music/entities/entities.dart';

class NewReleaseSong extends Equatable {
  final String title;
  final List<SongInfo?> songs;

  const NewReleaseSong({
    required this.title,
    required this.songs,
  });

  NewReleaseSong copyWith({
    String? title,
    List<SongInfo?>? songs,
  }) {
    return NewReleaseSong(
      title: title ?? this.title,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => [
    title,
    songs,
  ];

  @override
  bool? get stringify => true;
}
