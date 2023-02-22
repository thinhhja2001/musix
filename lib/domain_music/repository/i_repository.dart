import 'package:zing_mp3_api/zing_mp3_api.dart';

abstract class IRepository<T> {
  Future<T> getInfo(String id);

  Future<List<T>> getByQuery(String query);
}
