import 'package:equatable/equatable.dart';

import '../../../domain_playlist/entities/entities.dart';

class SectionPlaylist extends Equatable {
  final String? title;
  final List<MiniPlaylist>? items;

  const SectionPlaylist({
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

  SectionPlaylist copyWith({
    String? title,
    List<MiniPlaylist>? items,
  }) {
    return SectionPlaylist(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}
