import 'package:get/get.dart';

class IndexController extends GetxController {
  RxInt tabIndex = 0.obs;

  void  onTabClick(int newTab) {

    print('Tab $newTab');
    tabIndex(newTab);
  }
  void  onDoubleTabClick(int newTabs) {
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

