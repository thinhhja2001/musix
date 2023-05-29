abstract class IRecommendationRepo {
  Future<List<String>> recommendNextSong(String encodeId, int count);
  Future<List<String>> generateRecommendPlaylist(List<String> encodeIds);
}
