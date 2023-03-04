import 'package:equatable/equatable.dart';
import 'package:musix/utils/utils.dart';

class SectionAll extends Equatable {
  final String? title;
  final List<AllSearching>? items;

  const SectionAll({
    this.title,
    this.items,
  });

  SectionAll copyWith({
    String? title,
    List<AllSearching>? items,
  }) {
    return SectionAll(
      title: title,
      items: items,
    );
  }

  @override
  List<Object?> get props => [
        title,
        items,
      ];

  @override
  bool? get stringify => true;
}

class AllSearching extends Equatable {
  final String? id;
  final String? alias;
  final String? title;
  final String? artistsName;
  final String? thumbnail;
  final MusicType? type;

  const AllSearching({
    this.id,
    this.alias,
    this.title,
    this.artistsName,
    this.thumbnail,
    this.type,
  });

  AllSearching copyWith({
    String? id,
    String? alias,
    String? title,
    String? artistsName,
    String? thumbnail,
    MusicType? type,
  }) {
    return AllSearching(
      id: id ?? this.id,
      alias: alias ?? this.alias,
      title: title ?? this.title,
      artistsName: artistsName ?? this.artistsName,
      thumbnail: thumbnail ?? this.thumbnail,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
        title,
        thumbnail,
        type,
      ];

  @override
  bool? get stringify => true;
}
