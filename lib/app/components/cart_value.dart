import 'package:get/get.dart';
import 'package:red_tail/app/DAO/cartitemdao.dart';
import 'package:red_tail/app/modules/index/controllers/index_controller.dart';

import '../database/database.dart';

class CartCounter {
  static cartCounter() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    CartItemDao cartItemDao = database.cartItemDao;
    await cartItemDao.findAllCartItem().then((value) {
      Get.find<IndexController>().numberOfItemUpdater(number: value.length);
    });
  }
}
