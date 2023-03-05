import 'package:equatable/equatable.dart';

import '../../../domain_playlist/entities/entities.dart';

class SectionPlaylist extends Equatable {
  final String? title;
  final List<MiniPlaylist>? items;
  final int? total;

  const SectionPlaylist({
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

  SectionPlaylist copyWith({
    String? title,
    List<MiniPlaylist>? items,
    int? total,
  }) {
    return SectionPlaylist(
      title: title ?? this.title,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}
