import 'package:floor/floor.dart';

@entity
class SaleRequisition {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int? userId;
  final int? orderId;
  final int? productId;

  final String? customerName;
  final String? beatName;
  final String? productName;
  final String? catagory;
  final String? unit;
  final String? image;
  final double? price;
  final String? brand;
  final int? quantity;

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
