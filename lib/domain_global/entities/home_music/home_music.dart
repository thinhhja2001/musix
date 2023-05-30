import 'package:equatable/equatable.dart';

import '../../../domain_hub/entities/entities.dart';

class HomeMusic extends Equatable {
  final List<Hub>? hubs;
  final List<SectionPlaylist>? sectionPlaylists;
  final List<SectionSong>? newReleaseSongs;

  const HomeMusic({
    this.hubs,
    this.sectionPlaylists,
    this.newReleaseSongs,
  });

  HomeMusic copyWith({
    List<Hub>? hubs,
    List<SectionPlaylist>? sectionPlaylists,
    List<SectionSong>? newReleaseSongs,
  }) {
    return HomeMusic(
      hubs: hubs ?? this.hubs,
      sectionPlaylists: sectionPlaylists ?? this.sectionPlaylists,
      newReleaseSongs: newReleaseSongs ?? this.newReleaseSongs,
    );
  }

  @override
  List<Object?> get props => [
        hubs?.length,
        sectionPlaylists?.length,
        newReleaseSongs?.length,
      ];
}
