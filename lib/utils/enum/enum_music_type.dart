enum MusicType {
  playlist,
  song,
  artist,
  video,
}

Map<MusicType, String> convertMusicType = {
  MusicType.artist: 'Artist',
  MusicType.song: 'Song',
  MusicType.playlist: 'Playlist',
  MusicType.video: 'Video',
};
