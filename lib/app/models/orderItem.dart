import 'package:floor/floor.dart';

@entity
class OrderItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? orderId;
  String? userId;
  String? status;
  int? totalItem;
  String? dateTime;
  double? lattitude;
  double? longitude;
  double? totalPrice;
  String? beatName;
  String? CustomerName;
  String? Address;
  String? CustomerId;
  String? temperature;
  String? weather_code;

  OrderItem(
      {this.id,
      this.orderId,
      this.userId,
      this.CustomerId,
      this.status,
      this.totalItem,
      this.totalPrice,
      this.dateTime,
      this.lattitude,
      this.longitude,
      this.Address,
      this.beatName,
      this.CustomerName,
      this.temperature,
      this.weather_code});
}
