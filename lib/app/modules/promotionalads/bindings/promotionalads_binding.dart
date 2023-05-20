import 'package:get/get.dart';

import '../controllers/promotionalads_controller.dart';

class PromotionaladsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromotionaladsController>(
      () => PromotionaladsController(),
    );
  }
}
