class SearchMusicEvent {
  const SearchMusicEvent();
}

class SearchMusicQueryEvent implements SearchMusicEvent {
  final String query;
  const SearchMusicQueryEvent(this.query);
}

class SearchMusicSongLoadMoreEvent implements SearchMusicEvent {
  const SearchMusicSongLoadMoreEvent();
}

class SearchMusicArtistLoadMoreEvent implements SearchMusicEvent {
  const SearchMusicArtistLoadMoreEvent();
}

class SearchMusicPlaylistLoadMoreEvent implements SearchMusicEvent {
  const SearchMusicPlaylistLoadMoreEvent();
}

class SearchMusicVideoLoadMoreEvent implements SearchMusicEvent {}

class SearchMusicChangeToVideoEvent implements SearchMusicEvent {}
