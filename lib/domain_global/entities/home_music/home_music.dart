import 'package:equatable/equatable.dart';
import 'package:musix/domain_hub/entities/entities.dart';

class HomeMusic extends Equatable {
  final SectionPlaylist? recommendPlaylist;
  final SectionSong? recommendSongs;
  final List<Hub>? hubs;
  final SectionPlaylist? newPlaylists;
  final SectionPlaylist? randomPlaylist;
  final SectionArtist? representArtists;
  final List<SectionSong>? newReleaseSongs;

  const HomeMusic({
    this.recommendPlaylist,
    this.recommendSongs,
    this.hubs,
    this.newPlaylists,
    this.randomPlaylist,
    this.representArtists,
    this.newReleaseSongs,
  });

  HomeMusic copyWith({
    SectionPlaylist? recommendPlaylist,
    SectionSong? recommendSongs,
    List<Hub>? hubs,
    SectionPlaylist? newPlaylists,
    SectionPlaylist? randomPlaylist,
    SectionArtist? representArtists,
    List<SectionSong>? newReleaseSongs,
  }) {
    return HomeMusic(
      recommendPlaylist: recommendPlaylist ?? this.recommendPlaylist,
      recommendSongs: recommendSongs ?? this.recommendSongs,
      hubs: hubs ?? this.hubs,
      newPlaylists: newPlaylists ?? this.newPlaylists,
      randomPlaylist: randomPlaylist ?? this.randomPlaylist,
      representArtists: representArtists ?? this.representArtists,
      newReleaseSongs: newReleaseSongs ?? this.newReleaseSongs,
    );
  }

  @override
  List<Object?> get props => [
        recommendPlaylist,
        recommendSongs,
        representArtists,
        hubs,
        newPlaylists,
        randomPlaylist,
        newReleaseSongs,
      ];
}
