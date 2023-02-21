abstract class IRepository<T> {
  Future<T> getInfo(String id);
}
