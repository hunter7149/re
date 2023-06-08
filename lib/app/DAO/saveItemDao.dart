import 'package:floor/floor.dart';
import '../models/saveItem.dart';

@dao
abstract class SaveItemDao {
  @Query('SELECT * FROM SaveItem')
  Future<List<SaveItem>> findAllSaveItem();

  @Query('SELECT * FROM SaveItem WHERE saveId=:saveId')
  Future<List<SaveItem>> findAllSaveItemBySaveId(String saveId);

  @Query('SELECT * FROM SaveItem WHERE saveId = :id')
  Stream<SaveItem?> findSaveItemById(String id);

  @insert
  Future<void> insertSaveItem(SaveItem item);
  @Query('DELETE FROM SaveItem WHERE saveId = :saveId')
  Future<void> deleteBySaveId(String saveId);
}
