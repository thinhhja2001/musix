import 'package:musix/domain_song/repository/recommendations/i_recommendation_repo.dart';
import 'package:musix/domain_song/services/recommendations/i_recommendation_service.dart';
import 'package:musix/domain_song/services/recommendations/recommendation_service.dart';

class SongRecommendationRepo extends IRecommendationRepo {
  IRecommendationService recommendService = RecommendationService();
  @override
  Future<List<String>> generateRecommendPlaylist(List<String> encodeIds) async {
    final response =
        await recommendService.generateRecommendPlaylist(encodeIds);
    if (response['data'] == null) {
      return List.empty();
    }
    return (response['data'] as List).map((e) => e as String).toList();
  }

  @override
  Future<List<String>> recommendNextSong(String encodeId, int count) async {
    final response = await recommendService.recommendNextSong(encodeId, count);
    if (response['data'] == null) {
      return List.empty();
    }
    return (response['data'] as List).map((e) => e as String).toList();
  }
}
