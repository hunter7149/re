import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  final RxString argumentToDetailPage = RxString('you are the best!');
  final RxString argumentFromDetailPage = RxString('no argument yet');
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future goToDetailPage(var index) async {
    var result;
    if (index==0){
       Get.toNamed(Routes.ORDERHOME,
          id: Constants.nestedNavigationNavigatorId);
    }
    else if(index==1) {
      result = await Get.toNamed(Routes.PRODUCT,
          arguments: argumentToDetailPage.value,
          id: Constants.nestedNavigationNavigatorId);
      argumentFromDetailPage.value =
      result == null ? 'No argument' : (result as double).toStringAsFixed(0);
    }
    else {
      print('button $index');
    }
  }

  @override
  void onClose() {}

}

