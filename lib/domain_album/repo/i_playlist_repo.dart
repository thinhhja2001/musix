abstract class IPlaylistRepo {
  Future<dynamic> getGenreById(String id);
  Future<dynamic> getPlaylistById(String id);
}
