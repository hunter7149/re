import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  RxList<dynamic> data = <dynamic>["as", "bs"].obs;
  final RxString argumentToDetailPage = RxString('you are the best!');
  final RxString argumentFromDetailPage = RxString('no argument yet');

  Future goToDetailPage(var index) async {
    var result;
    if (index == 0) {
      Get.toNamed(Routes.ORDERHOME, id: Constants.nestedNavigationNavigatorId);
    } else if (index == 1) {
      result = await Get.toNamed(Routes.PRODUCT,
          arguments: argumentToDetailPage.value,
          id: Constants.nestedNavigationNavigatorId);
      argumentFromDetailPage.value = result == null
          ? 'No argument'
          : (result as double).toStringAsFixed(0);
    } else {
      print('button $index');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
