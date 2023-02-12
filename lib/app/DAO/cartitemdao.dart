import 'package:floor/floor.dart';
import 'package:red_tail/app/models/cartproduct.dart';

@dao
abstract class CartItemDao {
  @Query('SELECT * FROM CartItem')
  Future<List<CartItem>> findAllCartItem();

  @Query('SELECT * FROM CartItem WHERE userid = :id')
  Stream<CartItem?> findCartItemById(int id);

  @insert
  Future<void> insertCartItem(CartItem item);

  @Query('DELETE FROM CartItem WHERE userid = :userID')
  Future<void> deleteUsersByID(int userID);
}
