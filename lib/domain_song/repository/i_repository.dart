abstract class IRepository<T> {
  Future<T> getInfo(String id);

  Future<List<T>> getByQuery(String query);
}
