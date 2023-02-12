import 'package:floor/floor.dart';

@entity
class OrderItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int? orderId;
  final int? userId;
  final String? status;
  final int? totalItem;
  final String? dateTime;
  final double? lattitude;
  final double? longitude;
  final double? totalPrice;

  OrderItem({
    this.id,
    this.orderId,
    this.userId,
    this.status,
    this.totalItem,
    this.totalPrice,
    this.dateTime,
    this.lattitude,
    this.longitude,
  });
}
