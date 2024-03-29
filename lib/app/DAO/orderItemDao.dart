import 'package:floor/floor.dart';
import '../models/orderItem.dart';

@dao
abstract class OrderItemDao {
  @Query('SELECT * FROM OrderItem')
  Future<List<OrderItem>> findAllOrderItem();

  @Query('SELECT * FROM OrderItem WHERE orderId=:orderid')
  Future<List<OrderItem>> findAllOrderItemByOrderId(String orderid);

  @Query('SELECT * FROM OrderItem WHERE orderId = :id')
  Stream<OrderItem?> findOrderItemById(String id);

  @insert
  Future<void> insertOrderItem(OrderItem item);
}
