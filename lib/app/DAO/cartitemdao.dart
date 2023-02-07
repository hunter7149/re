import 'package:floor/floor.dart';
import 'package:red_tail/app/models/cartproduct.dart';

@dao
abstract class CartItemDao {
  @Query('SELECT * FROM cartItem')
  Future<List<cartItem>> findAllCartItem();

  @Query('SELECT * FROM cartItem WHERE userid = :id')
  Stream<cartItem?> findCartItemById(int id);

  @insert
  Future<void> insertCartItem(cartItem item);
}
