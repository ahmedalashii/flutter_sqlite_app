abstract class DbOperations<T> {
  /*
    * CRUD :
    * 1) CREATE
    * 2) READ >> SELECT
    * 3) UPDATE
    * 4) DELETE
  */

  Future<int> createRow(T object);

  Future<List<T>> getAllRows();

  Future<T?> getRow(int id);

  Future<bool> updateRow(T object);

  Future<bool> deleteRow(int id);

}
