import 'package:get/get.dart';

import '../controllers/leadershippage_controller.dart';

class LeadershippageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadershippageController>(
      () => LeadershippageController(),
    );
  }
}
