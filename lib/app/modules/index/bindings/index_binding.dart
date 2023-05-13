import 'package:get/get.dart';
import 'package:sales/app/modules/account/controllers/account_controller.dart';
import 'package:sales/app/modules/cart/controllers/cart_controller.dart';
import 'package:sales/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:sales/app/modules/orderpage/controllers/orderpage_controller.dart';
import 'package:sales/app/modules/services/controllers/services_controller.dart';

import '../../productinfo/controllers/productinfo_controller.dart';
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
    Get.lazyPut<OrderpageController>(
      () => OrderpageController(),
    );
    Get.lazyPut<ProductinfoController>(
      () => ProductinfoController(),
    );
  }
}
