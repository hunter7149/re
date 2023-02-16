import 'dart:async';

import 'package:get/get.dart';
import 'package:red_tail/app/components/cart_value.dart';
import 'package:red_tail/app/modules/cart/controllers/cart_controller.dart';
import 'package:red_tail/app/modules/orderHome/controllers/order_home_controller.dart';
import 'package:red_tail/app/modules/orderpage/controllers/orderpage_controller.dart';

class IndexController extends GetxController {
  RxBool shouldQuit = false.obs;

  updateShouldQuit() {
    shouldQuit.value = !shouldQuit.value;
    Timer(Duration(seconds: 2), () {
      shouldQuit.value = false;
      update();
    });
    update();
  }

  RxInt tabIndex = 0.obs;
  RxBool hasNewItem = false.obs;
  hasNewValueUpdater({required bool value}) {
    hasNewItem.value = value;
    update();
  }

  RxInt numberOfItem = 0.obs;
  numberOfItemUpdater({required int number}) {
    numberOfItem.value = number;
    if (number == 0) {
      hasNewValueUpdater(value: false);
    } else {
      hasNewValueUpdater(value: true);
    }

    update();
  }

  void onTabClick(int newTab) {
    if (newTab == 2) {
      Get.put(CartController());
      Get.find<CartController>().onInit();
      hasNewValueUpdater(value: false);
    } else {
      CartCounter.cartCounter();
    }
    if (newTab == 3) {
      Get.put(OrderpageController());
      Get.find<OrderpageController>().onInit();
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
