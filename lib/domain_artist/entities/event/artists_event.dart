class ArtistsEvent {
  const ArtistsEvent();
}

class GetArtistsEvent implements ArtistsEvent {
  final List<String> aliasList;
  final String title;
  const GetArtistsEvent({
    required this.aliasList,
    required this.title,
  });
}

class RemoveArtistEvent implements ArtistsEvent {
  final String alias;
  const RemoveArtistEvent(this.alias);
}

class BackArtistsEvent implements ArtistsEvent {
  const BackArtistsEvent();
}

class ArtistsResetEvent implements ArtistsEvent {}
