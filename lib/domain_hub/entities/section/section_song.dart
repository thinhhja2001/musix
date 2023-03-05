import 'package:equatable/equatable.dart';

import '../../../domain_song/entities/entities.dart';

class SectionSong extends Equatable {
  final String? title;
  final List<SongInfo>? items;
  final int? total;

  const SectionSong({
    this.title,
    this.items,
    this.total,
  });

  @override
  List<Object?> get props => [
        title,
        items,
      ];

  @override
  bool? get stringify => true;

  SectionSong copyWith({
    String? title,
    List<SongInfo>? items,
    int? total,
  }) {
    return SectionSong(
      title: title ?? this.title,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}
