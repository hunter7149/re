import 'package:get/get.dart';

import '../controllers/underdevelopment_controller.dart';

class UnderdevelopmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UnderdevelopmentController>(
      () => UnderdevelopmentController(),
    );
  }
}
