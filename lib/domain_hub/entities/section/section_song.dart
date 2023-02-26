import 'package:equatable/equatable.dart';
import '../../../domain_song/entities/entities.dart';

class SectionSong extends Equatable {
  final String? title;
  final List<SongInfo>? items;

  const SectionSong({
    this.title,
    this.items,
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
  }) {
    return SectionSong(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}
