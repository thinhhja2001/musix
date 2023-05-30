import 'package:dio/dio.dart';
import 'package:musix/config/exporter/environment_exporter.dart';
import 'package:musix/domain_song/services/recommendations/i_recommendation_service.dart';
import 'package:musix/global/repo/initial_repo.dart';
import 'package:musix/utils/utils.dart';

class RecommendationService extends InitialRepo
    implements IRecommendationService {
  final String databaseUrl = Environment.recommendationServerUrl;
  @override
  Future<Map<String, dynamic>> generateRecommendPlaylist(
      List<String> encodeIds) async {
    try {
      final url = "$databaseUrl/generated_recommend_playlist";
      var response = await dio.get(url, data: {"song_ids": encodeIds});
      return response.data;
    } on DioError catch (e) {
      throw ResponseException(
          statusCode: e.response?.statusCode,
          message: e.response?.data?["msg"] ?? exception);
    }
  }

  @override
  Future<Map<String, dynamic>> recommendNextSong(
      String encodeId, int count) async {
    final url = "$databaseUrl/next_song";
    var response = await dio
        .get(url, queryParameters: {"song_id": encodeId, "count": count});
    return response.data;
  }
}
