import 'package:equatable/equatable.dart';

import '../../../domain_video/entities/video_short.dart';

class SectionVideo extends Equatable {
  final String? title;
  final List<VideoShort>? items;

  const SectionVideo({
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

  SectionVideo copyWith({
    String? title,
    List<VideoShort>? items,
  }) {
    return SectionVideo(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }
}
