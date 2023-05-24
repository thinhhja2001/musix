abstract class IRecommendationService {
  Future<Map<String, dynamic>> recommendNextSong(String encodeId, int count);
  Future<Map<String, dynamic>> generateRecommendPlaylist(
      List<String> encodeIds);
}
