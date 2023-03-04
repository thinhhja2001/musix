enum SearchMusicStatusKey {
  global('searchMusicStatusKey'),
  song('songStatusKey'),
  playlist('playlistStatusKey'),
  artist('artistStatusKey'),
  video('videoStatusKey');

  const SearchMusicStatusKey(this.key);
  final String key;
}
