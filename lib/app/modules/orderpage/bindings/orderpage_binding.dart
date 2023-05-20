import 'package:get/get.dart';

import '../controllers/orderpage_controller.dart';

class OrderpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderpageController>(
      () => OrderpageController(),
    );
  }
}
