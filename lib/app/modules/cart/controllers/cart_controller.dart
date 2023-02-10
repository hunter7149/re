import 'package:get/get.dart';

import '../../../DAO/cartitemdao.dart';
import '../../../database/database.dart';
import '../../../models/cartproduct.dart';

class CartController extends GetxController {
  late CartItemDao cartItemDao;

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
  }

  RxList<cartItem> cartItems = <cartItem>[].obs;
  loadData() async {
    cartItems.clear();
    cartItems.refresh();
    await cartItemDao.findAllCartItem().then((value) {
      cartItems.value = value;
      cartItems.refresh();
      print("dta length -> ${cartItems.length}");
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
