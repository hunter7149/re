import 'dart:async';
import 'dart:ui';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/api/service/prefrences.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/sync/products/offlineproductsync.dart';

import '../../../DAO/cartitemdao.dart';
import '../../../components/cart_value.dart';
import '../../../components/internet_connection_checker.dart';
import '../../../database/database.dart';
import '../../../models/cartproduct.dart';

class ProductbController extends GetxController {
  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
    customerId.value = Pref.readData(key: Pref.CUSTOMER_CODE);
    Update();
    // requestItemCount();
  }

  RxString customerId = ''.obs;
  late CartItemDao cartItemDao;
  RxBool isOffline = false.obs;
  offlineUpdater({required bool status}) {
    isOffline.value = status;
    Update();
  }

  List<Color> randomeColor = [
    AppThemes.modernBlue,
    AppThemes.modernGreen,
    AppThemes.modernPurple,
    AppThemes.modernRed,
    AppThemes.modernCoolPink,
    AppThemes.modernSexyRed,
    AppThemes.modernChocolate,
    AppThemes.modernPlantation
  ];

  final count = 0.0.obs;
  RxMap<String, dynamic> products = <String, dynamic>{}.obs;
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  dataSetter(dynamic es) {
    data.value = es as Map<String, dynamic>;
    Update();
    print(data);
    requestPriceList();
    loadProducts();
    // requestItemCount();
  }

  RxList<dynamic> priceList = [].obs;
  requestPriceList() {
    priceList.value = Pref.readData(key: Pref.OFFLINE_CUSTOMIZED_DATA) ?? [];
  }

  getSellPriceByProductCode(
      {required String productCode, required String orgCode}) {
    for (var element in priceList) {
      if (element['SKU_CODE'].toString() == productCode.toString() &&
          element['ORG_CODE'].toString() == orgCode.toString()) {
        return element['SELL_VALUE'].toString();
      }
    }
    return null; // Return null if no match is found
  }

  RxBool isProductsLoading = false.obs;
  RxBool isItemCountLoading = false.obs;
  loadProducts() async {
    isProductsLoading.value = true;
    Update();
    dynamic brandProducts = Pref.readData(key: Pref.OFFLINE_DATA);
    if (brandProducts.isEmpty) {
      await OFFLINEPRODUCTSYNC();
    }
    products.value = brandProducts['${data['brand']}'] ?? {};
    products.refresh();

    isProductsLoading.value = false;
    Update;
  }

  RxBool isAdded = false.obs;
  isAddedUpdater() {
    isAdded.value = true;
    Update();
    Timer(Duration(seconds: 1), () {
      isAdded.value = false;
      Update();
    });
  }

  RxDouble totalPrice = 0.0.obs;
  calculation({required double price, required int quanity}) {
    totalPrice.value = price * quanity;
    Update();
    return totalPrice.value;
  }

  totalpriceUpdater() {
    totalPrice.value = 0.0;
    Update();
  }
  // requestItemCount() async {
  //   isItemCountLoading.value = true;
  //   Update();
  //   if (await IEchecker.checker()) {
  //     try {
  //       await Repository().getBrandItemCount(
  //           body: {"brand": data['brand']}).then((value) async {
  //         if (value == null) {
  //           offlineProductsModule();
  //           isItemCountLoading.value = false;

  //           Update();
  //         } else {
  //           products.clear();
  //           products.value = value['value'] ?? [];
  //           products.refresh();

  //           // Pref.writeData(key: data['brand'], value: products.value);
  //           isItemCountLoading.value = false;

  //           Update();
  //           offlineUpdater(status: false);
  //         }
  //       });
  //     } on Exception {
  //       offlineProductsModule();
  //       isItemCountLoading.value = false;
  //       Update();
  //       // Get.snackbar("Server error", "Data loaded in offline mode!",
  //       //     backgroundColor: AppThemes.modernSexyRed,
  //       //     snackPosition: SnackPosition.TOP,
  //       //     borderRadius: 0,
  //       //     animationDuration: Duration(seconds: 0),
  //       //     colorText: Colors.white,
  //       //     duration: Duration(seconds: 4));
  //     }
  //   } else {
  //     offlineProductsModule();
  //     // Get.snackbar("No internet", "Data loaded in offline mode!",
  //     //     borderRadius: 0,
  //     //     animationDuration: Duration(seconds: 0),
  //     //     backgroundColor: AppThemes.modernSexyRed,
  //     //     snackPosition: SnackPosition.TOP,
  //     //     colorText: Colors.white,
  //     //     duration: Duration(seconds: 4));
  //   }
  // }

  // offlineProductsModule() async {
  //   offlineUpdater(status: true);
  //   dynamic offline = Pref.readData(key: Pref.OFFLINE_DATA);
  //   Map<String, dynamic> offline2 = offline['${data['brand']}'] ?? {};
  //   List<String> offline2Keys = offline2.keys.toList();
  //   products.clear();
  //   for (int i = 0; i < offline2.length; i++) {
  //     products.add({
  //       "GENERIC_NAME": offline2Keys[i],
  //       "TTL": offline2[offline2Keys[i]]?.length
  //     });
  //     products.refresh();
  //   }
  //   isItemCountLoading.value = false;
  //   Update();
  // }
  addToCart({required CartItem data}) async {
    if (await ICHECKER.checkConnection()) {
      print("INTERNET");
    } else {
      print("NO INTERNET");
    }

    // Check if the item already exists in the cart
    CartItem? existingItem = await cartItemDao
        .findCartItemByCustomerId(data.productSku!, data.customerName!)
        .first;

    if (existingItem != null) {
      // If the item already exists, update its quantity
      CartItem temporaryItem = existingItem;
      if (existingItem.customerName.toString() == customerId.value) {
        existingItem.quantity = (existingItem.quantity! + data.quantity!);
        existingItem.price = (existingItem.price! + data.price!);

        if (await cartItemDao
            .updateCartItem(existingItem)
            .then((value) => true)) {
          totalpriceUpdater();
          Get.closeAllSnackbars();
          CartCounter.cartCounter();

          await isAddedUpdater();

          await COMMONWIDGET.successAlert(message: "Added to cart!");
          Timer(Duration(seconds: 1), () async {
            Get.back();
          });
          // Get.snackbar(
          //   "Success",
          //   "Product added successfully!",
          //   backgroundColor: Colors.green,
          //   colorText: Colors.white,
          // );
        } else {
          totalpriceUpdater();
          Get.snackbar(
            "Failure",
            "Product quantity was not updated!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        if (await cartItemDao.insertCartItem(data).then((value) => true)) {
          totalpriceUpdater();
          CartCounter.cartCounter();
          isAddedUpdater();
          await COMMONWIDGET.successAlert(message: "Added to cart!");
          Timer(Duration(seconds: 1), () {
            Get.back();
          });
        } else {
          totalpriceUpdater();
          Get.snackbar(
            "Failure",
            "Product was not added!",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } else {
      // If the item does not exist, insert it into the cart
      if (await cartItemDao.insertCartItem(data).then((value) => true)) {
        totalpriceUpdater();
        CartCounter.cartCounter();
        isAddedUpdater();
        await COMMONWIDGET.successAlert(message: "Added to cart!");
        Timer(Duration(seconds: 1), () {
          Get.back();
        });
      } else {
        totalpriceUpdater();
        Get.snackbar(
          "Failure",
          "Product was not added!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    initValues();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
