import 'package:get/get.dart';
import 'package:sales/app/DAO/cartitemdao.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/modules/index/controllers/index_controller.dart';

import '../database/database.dart';
import '../models/cartproduct.dart';

class CartCounter {
  static cartCounter() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    CartItemDao cartItemDao = database.cartItemDao;
    await cartItemDao.findAllCartItem().then((value) {
      String currentCustomerCode = Pref.readData(key: Pref.CUSTOMER_CODE);
      List<CartItem> tempCart = [];
      tempCart.forEach((element) {
        if (element.customerName == currentCustomerCode) {
          tempCart.add(element);
        }
      });

      Get.find<IndexController>().numberOfItemUpdater(number: tempCart.length);
    });
  }
}
