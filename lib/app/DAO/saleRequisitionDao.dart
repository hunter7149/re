import 'package:floor/floor.dart';

import '../models/saleRequisition.dart';

@dao
abstract class SaleRequisitionDao {
  @Query('SELECT * FROM SaleRequisition')
  Future<List<SaleRequisition>> findAllSaleItem();

  @Query(
      'SELECT * FROM SaleRequisition WHERE orderId = :orderId AND userId =:userId')
  Future<List<SaleRequisition>> findAllSaleItemBySaleId(
      String orderId, String userId);

  @Query('SELECT * FROM SaleRequisition WHERE orderId = :id')
  Stream<SaleRequisition?> findSaleItemById(String id);

  @Query('DELETE FROM SaleRequisition WHERE orderId = :saveId')
  Future<void> deleteBySaveId(String saveId);
  @insert
  Future<void> insertSaleItem(SaleRequisition item);
}
