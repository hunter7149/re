import 'package:floor/floor.dart';

@entity
class cartItem {
  @primaryKey
  final int id;
  final int userid;
  final int productId;
  final String customerName;
  final String beatName;
  final String productName;
  final String catagory;
  final String unit;
  final String image;
  final double price;
  final String brand;
  final int quantity;

  cartItem(
      this.id,
      this.userid,
      this.productId,
      this.customerName,
      this.beatName,
      this.productName,
      this.catagory,
      this.unit,
      this.image,
      this.price,
      this.brand,
      this.quantity);
}
