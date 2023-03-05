import 'package:equatable/equatable.dart';

import '../../../domain_video/entities/video_short.dart';

class SectionVideo extends Equatable {
  final String? title;
  final List<VideoShort>? items;
  final int? total;

  const SectionVideo({
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

  SectionVideo copyWith({
    String? title,
    List<VideoShort>? items,
    int? total,
  }) {
    return SectionVideo(
      title: title ?? this.title,
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}
