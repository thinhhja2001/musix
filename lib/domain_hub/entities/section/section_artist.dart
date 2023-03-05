import 'package:equatable/equatable.dart';

import '../../../domain_artist/entities/entities.dart';

class SectionArtist extends Equatable {
  final String? title;
  final List<MiniArtist>? items;
  final int? total;

  const SectionArtist({
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

  SectionArtist copyWith({
    String? title,
    List<MiniArtist>? items,
    int? total,
  }) {
    return SectionArtist(
      title: title ?? this.title,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}
