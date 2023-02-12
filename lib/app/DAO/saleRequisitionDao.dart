import 'package:floor/floor.dart';
import 'package:red_tail/app/models/cartproduct.dart';

import '../models/saleRequisition.dart';

@dao
abstract class SaleRequisitionDao {
  @Query('SELECT * FROM SaleRequisition')
  Future<List<SaleRequisition>> findAllSaleItem();

  @Query(
      'SELECT * FROM SaleRequisition WHERE orderId = :orderId AND userId =:userId')
  Future<List<SaleRequisition>> findAllSaleItemBySaleId(
      int orderId, int userId);

  @Query('SELECT * FROM SaleRequisition WHERE userid = :id')
  Stream<SaleRequisition?> findSaleItemById(int id);

  @insert
  Future<void> insertSaleItem(SaleRequisition item);
}
