import 'package:get/get.dart';
import 'package:red_tail/app/modules/account/controllers/account_controller.dart';
import 'package:red_tail/app/modules/cart/controllers/cart_controller.dart';
import 'package:red_tail/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:red_tail/app/modules/services/controllers/services_controller.dart';

import '../controllers/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndexController>(
      () => IndexController(),
    );
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
    );
    Get.lazyPut<ServicesController>(
          () => ServicesController(),
    );
    Get.lazyPut<CartController>(
          () => CartController(),
    );
    Get.lazyPut<AccountController>(
          () => AccountController(),
    );
  }
}
