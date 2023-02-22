import 'package:equatable/equatable.dart';

import '../playlist/mini_playlist.dart';

class Topic extends Equatable {
  final String? title;
  final List<MiniPlaylist>? items;

  const Topic({
    this.title,
    this.items,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        items,
      ];

  Topic copyWith({
    String? title,
    List<MiniPlaylist>? items,
  }) {
    return Topic(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }

  @override
  bool? get stringify => true;
}
