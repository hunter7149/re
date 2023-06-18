import 'package:floor/floor.dart';

@entity
class SaleRequisition {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? userId;
  String? orderId;
  String? productId;
  String? productSku;
  String? customerId;
  String? customerName;
  String? beatName;
  String? productName;
  String? catagory;
  String? unit;
  String? image;
  double? price;
  String? brand;
  int? quantity;
  double? unitprice;

  SaleRequisition(
      {this.id,
      this.userId,
      this.orderId,
      this.customerId,
      this.productSku,
      this.productId,
      this.customerName,
      this.beatName,
      this.productName,
      this.catagory,
      this.unit,
      this.image,
      this.price,
      this.brand,
      this.quantity,
      this.unitprice});
}
