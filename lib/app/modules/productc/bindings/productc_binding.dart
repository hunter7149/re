import 'package:get/get.dart';

import '../controllers/productc_controller.dart';


class ProductcBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductcController>(
          () => ProductcController(),
    );
  }
}