import 'package:floor/floor.dart';
import 'package:sales/app/models/cartproduct.dart';

@dao
abstract class CartItemDao {
  @Query('SELECT * FROM CartItem')
  Future<List<CartItem>> findAllCartItem();

  @Query('SELECT * FROM CartItem WHERE productId = :id')
  Stream<CartItem?> findCartItemById(String id);

  @insert
  Future<void> insertCartItem(CartItem item);

  @Query('DELETE FROM CartItem WHERE productId = :id')
  Future<void> deleteCartItemByID(String id);
  @Query('DELETE FROM CartItem WHERE userId = :userId')
  Future<void> deleteCartItemByuserID(int userId);
  @update
  Future<int?> updateCartItem(CartItem item);
  // @Query(
  //     'UPDATE CartItem SET price = :price WHERE userId = :userId AND productId = :productId AND id = :id')
  // Future<int?> updateData(int userId, int productId, double price, int id);
}
