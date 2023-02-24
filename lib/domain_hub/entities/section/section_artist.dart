import 'package:equatable/equatable.dart';
import 'package:musix/domain_artist/entities/entities.dart';

class SectionArtist extends Equatable {
  final String? title;
  final List<MiniArtist>? items;

  const SectionArtist({
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

  SectionArtist copyWith({
    String? title,
    List<MiniArtist>? items,
  }) {
    return SectionArtist(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}
