class SearchMusicEvent {
  const SearchMusicEvent();
}

class SearchMusicQueryEvent implements SearchMusicEvent {
  final String query;
  const SearchMusicQueryEvent(this.query);
}
