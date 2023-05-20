import 'package:get/get.dart';

import '../controllers/addcustomer_controller.dart';

class AddcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddcustomerController>(
      () => AddcustomerController(),
    );
  }
}
