import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../DAO/cartitemdao.dart';
import '../../../components/cart_value.dart';
import '../../../components/internet_connection_checker.dart';
import '../../../database/database.dart';
import '../../../models/cartproduct.dart';

class ProductinfoController extends GetxController {
  late CartItemDao cartItemDao;
  returnPrice({required String productCode}) {
    RxDouble price = 500.00.obs;
    if (productCode == '3000077') {
      price.value = 110.00;
      update();
    } else if (productCode == "3000078") {
      price.value = 110.00;
      update();
    } else if (productCode == "3000079") {
      price.value = 110.00;
      update();
    } else if (productCode == "3000080") {
      price.value = 110.00;
      update();
    } else if (productCode == "3000082") {
      price.value = 222.22;
      update();
    } else if (productCode == "3000083") {
      price.value = 222.22;
      update();
    } else if (productCode == "3000099") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000100") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000101") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000102") {
      price.value = 675.00;
      update();
    } else if (productCode == "3000103") {
      price.value = 675.00;
      update();
    }

    return price.value;
  }

  RxMap<String, dynamic> products = <String, dynamic>{}.obs;
  RxMap<String, dynamic> tempData = <String, dynamic>{}.obs;
  setData({required dynamic data}) async {
    tempData.value = data as Map<String, dynamic> ?? {};
    tempData.refresh();
    products.value = data as Map<String, dynamic> ?? {};
    products.refresh();
    calculation(price: 500, quanity: 1);
    update();
  }

  initValues() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('cartlist.db').build();
    cartItemDao = database.cartItemDao;
  }

  RxDouble totalPrice = 0.0.obs;
  calculation({required double price, required int quanity}) {
    totalPrice.value = price * quanity;

    update();
    return totalPrice;
  }

  addToCart({required CartItem data}) async {
    if (await ICHECKER.checkConnection()) {
      print("INTERNET");
    } else {
      print("NO INTERNET");
    }

    // Check if the item already exists in the cart
    CartItem? existingItem =
        await cartItemDao.findCartItemById(data.productId!).first;

    if (existingItem != null && data != null) {
      // If the item already exists, update its quantity
      CartItem temporaryItem = existingItem;

      existingItem.quantity = (existingItem.quantity! + data.quantity!);
      existingItem.price = (existingItem.price! + data.price!);

      if (await cartItemDao
          .updateCartItem(existingItem)
          .then((value) => true)) {
        CartCounter.cartCounter();
        isAddedUpdater();
        // successAlert();
        // Timer(Duration(seconds: 1), () {
        //   Get.back();
        // });
        // Get.snackbar(xs
        //   "Success",
        //   "Product added successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else {
        Get.snackbar(
          "Failure",
          "Product quantity was not updated!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      // If the item does not exist, insert it into the cart
      if (await cartItemDao.insertCartItem(data).then((value) => true)) {
        CartCounter.cartCounter();
        isAddedUpdater();
        // Get.snackbar(
        //   "Success",
        //   "Product added successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else {
        Get.snackbar(
          "Failure",
          "Product was not added!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  RxBool isAdded = false.obs;
  isAddedUpdater() {
    isAdded.value = true;
    update();
    Timer(Duration(seconds: 1), () {
      isAdded.value = false;
      update();
    });
  }

  successAlert() async {
    await Get.generalDialog(
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4 * anim1.value,
                sigmaY: 4 * anim1.value,
              ),
              child: FadeTransition(
                child: child,
                opacity: anim1,
              ),
            ),
        pageBuilder: (ctx, anim1, anim2) {
          TextEditingController quanity = TextEditingController();
          quanity.text = 1.toString();

          return MediaQuery(
            data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image.asset("assets/images/success.png")),
                        Text(
                          "Added to cart!",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        )
                      ],
                    )
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [],
            ),
          );
        });
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
