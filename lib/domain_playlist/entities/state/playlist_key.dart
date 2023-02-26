enum PlaylistStatusKey {
  global('playlistGlobalKey'),
  info('playlistInfoKey'),
  playlists('playlistsKey');

  const PlaylistStatusKey(this.key);
  final String key;
}
