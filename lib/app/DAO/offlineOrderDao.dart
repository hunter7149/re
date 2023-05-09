import 'package:floor/floor.dart';

import 'package:sales/app/models/offlineorder.dart';

@dao
abstract class OfflineOrderDao {
  @Query('SELECT * FROM OfflineOrder')
  Future<List<OfflineOrder>> findAllOfflineOrder();

  @Query('SELECT * FROM OfflineOrder WHERE orderId = :id')
  Stream<OfflineOrder?> findorderItemById(String id);

  @Query('DELETE FROM OfflineOrder')
  Future<void> deleteAllOfflineOrder();
  @insert
  Future<void> insertCartItem(OfflineOrder item);

  @Query('DELETE FROM OfflineOrder WHERE orderId = :id')
  Future<void> deleteCartItemByID(String id);
  @Query('DELETE FROM OfflineOrder WHERE status = :status')
  Future<void> deleteCartItemByuserID(String status);
  @update
  Future<int?> updateCartItem(OfflineOrder item);
}
