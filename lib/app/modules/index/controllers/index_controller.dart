import 'package:get/get.dart';
import 'package:red_tail/app/modules/cart/controllers/cart_controller.dart';

class IndexController extends GetxController {
  RxInt tabIndex = 0.obs;

  void onTabClick(int newTab) {
    if (newTab == 2) {
      Get.put(CartController());
      Get.find<CartController>().onInit();
    }

    print('Tab $newTab');
    tabIndex(newTab);
  }

  void onDoubleTabClick(int newTabs) {
    print('Tabb $newTabs');
    tabIndex(newTabs);
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
