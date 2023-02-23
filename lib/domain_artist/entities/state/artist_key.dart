enum ArtistStatusKey {
  global('artistGlobalKey'),
  info('artistInfoKey'),
  artists('artistsKey');

  const ArtistStatusKey(this.key);
  final String key;
}
