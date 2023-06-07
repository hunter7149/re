import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sales/app/components/app_strings.dart';
import 'package:sales/app/components/cart_value.dart';
import 'package:sales/app/modules/cart/controllers/cart_controller.dart';
import 'package:sales/app/modules/orderpage/controllers/orderpage_controller.dart';
import 'package:sales/app/sync/products/offlineordersync.dart';
import 'package:sales/app/sync/products/offlineproductsync.dart';

class IndexController extends GetxController {
  RxBool isBeatCustomerSelected = false.obs;
  RxBool shouldQuit = false.obs;
  RxBool isDeviceConnected = false.obs;
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
      // Get.find<CartController>().onInit();
      // Get.find<CartController>().initialDropdownValue();
      Get.find<CartController>().getlocation();
      Get.find<CartController>().loadData();
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

  internetChecker() {
    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print("${result}");
      Get.put(CartController());
      if (result != ConnectivityResult.none) {
        isDeviceConnected.value =
            await InternetConnectionChecker().hasConnection;
        update();
        Get.find<CartController>()
            .connectionUpdater(status: isDeviceConnected.value);
        if (await InternetConnectionChecker().hasConnection) {
          // await OFFLINEORDERSYNC().onlineSync();
          await OFFLINEPRODUCTSYNC().offlineDataSync(brands: AppStrings.brands);
        }

        print(
            "Has internet----${await InternetConnectionChecker().hasConnection}");
      } else {
        isDeviceConnected.value =
            await InternetConnectionChecker().hasConnection;
        update();
        Get.find<CartController>()
            .connectionUpdater(status: isDeviceConnected.value);
        print("Has internet----${isDeviceConnected.value}");
      }
    });
  }
//-------------------Beat customer select---------------//

  @override
  void onInit() {
    super.onInit();
    internetChecker();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
