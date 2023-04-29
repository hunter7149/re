import 'package:floor/floor.dart';

@entity
class OrderItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? orderId;
  int? userId;
  String? status;
  int? totalItem;
  String? dateTime;
  double? lattitude;
  double? longitude;
  double? totalPrice;
  String? beatName;
  String? CustomerName;

  OrderItem(
      {this.id,
      this.orderId,
      this.userId,
      this.status,
      this.totalItem,
      this.totalPrice,
      this.dateTime,
      this.lattitude,
      this.longitude,
      this.beatName,
      this.CustomerName});
}
