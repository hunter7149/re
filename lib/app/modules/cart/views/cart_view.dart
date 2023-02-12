import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Cart',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Obx(() => controller.cartItems.length == 0
            ? Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/emptycart.jpg",
                        height: 200,
                      ),
                      Text("You have no items in your cart!"),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: AppThemes.PrimaryLightColor,
                    child: Row(
                      children: const [
                        Icon(Icons.location_on),
                        SizedBox(width: 10),
                        Text('Deliver to Shariar - Rochester 14404')
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Subtotal',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 10),
                              Obx(
                                () => RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: 'BDT ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      TextSpan(
                                        text: controller.totalPrice.value
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // WidgetSpan(
                                      //   child: Transform.translate(
                                      //     offset: const Offset(0.0, -7.0),
                                      //     child: const Text(
                                      //       '99',
                                      //       style: TextStyle(
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                            onPressed: () {
                              // controller.getLocation();
                              confirmAlert(controller: controller);
                            },
                            style: TextButton.styleFrom(
                                //foregroundColor: Colors.white,
                                backgroundColor: Colors.yellow[700]),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Proceed to checkout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // controller.cartItems.length == 0
                  //           ? Center(
                  //               child: Container(
                  //                 height: 50,
                  //                 child: Text(
                  //                   "You have no item in your cart!",
                  //                   style: TextStyle(color: Colors.red),
                  //                 ),
                  //               ),
                  //             )
                  //           :

                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        TextEditingController quantity =
                            TextEditingController();
                        quantity.text =
                            controller.cartItems[index].quantity.toString();
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 0.7, color: Colors.grey.shade800)),
                              // color: Colors.red,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                      child: CachedNetworkImage(
                                        imageUrl: controller
                                            .cartItems[index].image
                                            .toString(),
                                        // height: 160,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (ctx, url, err) =>
                                            Image.asset(
                                          'assets/images/noprev.png',
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                  "${controller.cartItems[index].productName}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                  "Brand: ${controller.cartItems[index].brand}",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  "Price: ${controller.cartItems[index].price} Tk",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              Text(
                                                  "Price: ${controller.cartItems[index].catagory} Tk",
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ZoomTapAnimation(
                                                onTap: () {
                                                  int a = int.tryParse(
                                                          quantity.text) ??
                                                      0;
                                                  if (a > 1) {
                                                    a--;
                                                  } else {
                                                    a = 1;
                                                  }
                                                  if (int.parse(quantity.text) -
                                                          1 ==
                                                      0) {
                                                    quantity.text = "1";
                                                  }
                                                  double unitPrice = controller
                                                          .cartItems[index]
                                                          .price! /
                                                      int.parse(quantity.text);
                                                  quantity.text = a.toString();

                                                  String price = (unitPrice * a)
                                                      .toStringAsFixed(2);
                                                  controller
                                                      .priceQuantiyUpdater(
                                                          index: index,
                                                          quantity:
                                                              quantity.text,
                                                          price: price);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  padding: EdgeInsets.all(5),
                                                  child: Center(
                                                      child: Icon(
                                                    FontAwesomeIcons.minus,
                                                    color: Colors.grey.shade800,
                                                    size: 15,
                                                  )),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                height: 40,
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (Value) {
                                                    if (quantity
                                                        .text.isNotEmpty) {
                                                      if (int.parse(
                                                              quantity.text) >
                                                          0) {
                                                        double unitPrice =
                                                            controller
                                                                    .cartItems[
                                                                        index]
                                                                    .price! /
                                                                controller
                                                                    .cartItems[
                                                                        index]
                                                                    .quantity!;

                                                        String price = (unitPrice *
                                                                int.parse(
                                                                    quantity
                                                                        .text))
                                                            .toStringAsFixed(2);
                                                        controller
                                                            .priceQuantiyUpdater(
                                                                index: index,
                                                                quantity:
                                                                    quantity
                                                                        .text,
                                                                price: price);
                                                      }
                                                    }
                                                  },
                                                  controller: quantity,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 0.7,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ZoomTapAnimation(
                                                onTap: () {
                                                  int a = int.tryParse(
                                                          quantity.text) ??
                                                      0;
                                                  a++;
                                                  double unitPrice = controller
                                                          .cartItems[index]
                                                          .price! /
                                                      int.parse(quantity.text);
                                                  quantity.text = a.toString();

                                                  String price = (unitPrice * a)
                                                      .toStringAsFixed(2);
                                                  controller
                                                      .priceQuantiyUpdater(
                                                          index: index,
                                                          quantity:
                                                              quantity.text,
                                                          price: price);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  padding: EdgeInsets.all(5),
                                                  child: Center(
                                                      child: Icon(
                                                    FontAwesomeIcons.plus,
                                                    color: Colors.grey.shade800,
                                                    size: 15,
                                                  )),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Positioned(
                                right: 17,
                                top: 11,
                                child: ZoomTapAnimation(
                                  onTap: () {
                                    deleteAlert(
                                        controller: controller, index: index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                  ),
                ],
              )));
  }

  static deleteAlert({required CartController controller, required int index}) {
    Get.generalDialog(
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Confirmation",
                    style: TextStyle(),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Icon(
                        Icons.close,
                        color: Colors.red.shade800,
                        size: 20,
                      )),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  )
                ],
              ),
              content: Container(
                // height: 80,
                child: Text(
                    "Are you sure to remove ${controller.cartItems[index].productName} ?"),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.red.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child:
                        Text("Delete", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }

  static confirmAlert({required CartController controller}) {
    Get.generalDialog(
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Confirmation",
                    style: TextStyle(),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Icon(
                        Icons.close,
                        color: Colors.red.shade800,
                        size: 20,
                      )),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  )
                ],
              ),
              content: Container(
                // height: 80,
                child: Text("Are you sure to palce this order ?"),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.requestCheckout();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text("Place Order",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }
}
