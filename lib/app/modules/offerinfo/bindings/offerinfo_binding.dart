import 'package:get/get.dart';

import '../controllers/offerinfo_controller.dart';

class OfferinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferinfoController>(
      () => OfferinfoController(),
    );
  }
}
