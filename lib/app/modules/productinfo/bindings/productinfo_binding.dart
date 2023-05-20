import 'package:get/get.dart';

import '../controllers/productinfo_controller.dart';

class ProductinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductinfoController>(
      () => ProductinfoController(),
    );
  }
}
