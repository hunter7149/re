import 'package:get/get.dart';
import 'package:sales/app/modules/orderHome/controllers/order_home_controller.dart';

class OrderHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHomeController>(
      () => OrderHomeController(),
    );
  }
}
