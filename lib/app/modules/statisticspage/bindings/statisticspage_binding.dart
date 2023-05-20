import 'package:get/get.dart';

import '../controllers/statisticspage_controller.dart';

class StatisticspageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticspageController>(
      () => StatisticspageController(),
    );
  }
}
