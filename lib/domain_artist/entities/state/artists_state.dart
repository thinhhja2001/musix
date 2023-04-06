import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../entities.dart';

class ArtistsState extends Equatable {
  final Map<String, Status>? status;
  final List<MiniArtist>? artists;
  final String? title;
  final String? thumbnail;

  const ArtistsState({
    this.status,
    this.artists,
    this.title,
    this.thumbnail,
  });

  ArtistsState copyWith({
    Map<String, Status>? status,
    List<MiniArtist>? artists,
    String? title,
    String? thumbnail,
  }) {
    return ArtistsState(
      status: status ?? this.status,
      artists: artists ?? this.artists,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [
        status,
        artists?.length,
        title,
      ];

  @override
  bool? get stringify => true;
}
