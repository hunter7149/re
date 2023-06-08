import 'package:floor/floor.dart';

@entity
class CartItem {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? userId;
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
  double? unitPrice;

  CartItem(
      {this.id,
      this.userId,
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
      this.unitPrice});
}
