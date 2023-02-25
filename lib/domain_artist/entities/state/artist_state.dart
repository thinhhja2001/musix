import 'package:equatable/equatable.dart';
import '../entities.dart';

import '../../../utils/utils.dart';

class ArtistState extends Equatable {
  final Map<String, Status>? status;
  final List<MiniArtist?>? artists;
  final Artist? info;

  const ArtistState({
    this.status,
    this.artists,
    this.info,
  });

  ArtistState copyWith({
    Map<String, Status>? status,
    List<MiniArtist?>? artists,
    Artist? info,
  }) {
    return ArtistState(
      status: status ?? this.status,
      artists: artists ?? this.artists,
      info: info ?? this.info,
    );
  }

  @override
  List<Object?> get props => [
        status,
        artists,
        info,
      ];

  @override
  bool? get stringify => true;
}
