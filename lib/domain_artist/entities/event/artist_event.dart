class ArtistEvent {
  const ArtistEvent();
}

class ArtistGetInfoEvent implements ArtistEvent {
  final String alias;
  const ArtistGetInfoEvent(this.alias);
}

class ArtistBackInfoEvent implements ArtistEvent {
  const ArtistBackInfoEvent();
}

class ArtistResetEvent implements ArtistEvent {}
