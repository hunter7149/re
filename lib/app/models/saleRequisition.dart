import 'package:floor/floor.dart';

@entity
class SaleRequisition {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? userId;
  int? orderId;
  String? productId;

  String? customerName;
  String? beatName;
  String? productName;
  String? catagory;
  String? unit;
  String? image;
  double? price;
  String? brand;
  int? quantity;

  SaleRequisition(
      {this.id,
      this.userId,
      this.orderId,
      this.productId,
      this.customerName,
      this.beatName,
      this.productName,
      this.catagory,
      this.unit,
      this.image,
      this.price,
      this.brand,
      this.quantity});
}
