import 'package:get/get.dart';

import '../controllers/productb_controller.dart';

class ProductbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductbController>(
      () => ProductbController(),
    );
  }
}
