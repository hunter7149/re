import 'package:floor/floor.dart';
import '../models/orderItem.dart';

@dao
abstract class OrderItemDao {
  @Query('SELECT * FROM OrderItem')
  Future<List<OrderItem>> findAllOrderItem();

  @Query('SELECT * FROM OrderItem WHERE userId=:userId')
  Future<List<OrderItem>> findAllOrderItemBySaleId(int userId);

  @Query('SELECT * FROM OrderItem WHERE orderId = :id')
  Stream<OrderItem?> findOrderItemById(int id);

  @insert
  Future<void> insertOrderItem(OrderItem item);
}
