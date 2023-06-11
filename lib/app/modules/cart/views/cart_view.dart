import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
        body: Obx(() => controller.cartItems.length == 0
            ? Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/emptyproduct.jpg",
                        height: 200,
                      ),
                      Text(
                        "No product in cart!",
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              )
            : SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Container(
                        // width: double.maxFinite,
                        // color: AppThemes.modernGreen,

                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: AppThemes.modernGreen,
                              ),
                              Obx(() => Flexible(
                                    child: Text(
                                      "${controller.address.value}",
                                      style: TextStyle(
                                          color: AppThemes.modernGreen,
                                          fontSize: 16),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ))
                            ]),
                      )),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        bottom: 130,
                        child: ListView.builder(
                          itemCount: controller.cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            TextEditingController quantity =
                                TextEditingController();
                            quantity.text =
                                controller.cartItems[index].quantity.toString();
                            return Dismissible(
                              background: Container(
                                color: AppThemes.modernRed,
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              // key: Key("${index}"),
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                deleteAlert(
                                    controller: controller, index: index);
                                controller.screenRefresh();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 1,
                                            color: AppThemes.modernGreen
                                                .withOpacity(0.6))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  // "https://as2.ftcdn.net/v2/jpg/04/66/23/33/1000_F_466233320_J92tRR3Pq1KPiEoveQGBO40gJFNCCPyz.jpg",
                                                  controller
                                                      .cartItems[index].image
                                                      .toString(),
                                              height: 80,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget: (ctx, url, err) =>
                                                  Image.asset(
                                                'assets/images/noprev.png',
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        "${controller.cartItems[index].productName}"
                                                                    .length >
                                                                15
                                                            ? "${controller.cartItems[index].productName}"
                                                                .substring(
                                                                    0, 15)
                                                            : "${controller.cartItems[index].productName}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "Brand: ${controller.cartItems[index].brand}",
                                                        style: TextStyle(
                                                            fontSize: 14)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ZoomTapAnimation(
                                                          onTap: () {
                                                            int a = int.tryParse(
                                                                    quantity
                                                                        .text) ??
                                                                0;
                                                            if (a > 1) {
                                                              a--;
                                                            } else {
                                                              a = 1;
                                                            }
                                                            if (int.parse(quantity
                                                                        .text) -
                                                                    1 ==
                                                                0) {
                                                              quantity.text =
                                                                  "1";
                                                            }
                                                            double unitPrice = controller
                                                                    .cartItems[
                                                                        index]
                                                                    .price! /
                                                                int.parse(
                                                                    quantity
                                                                        .text);
                                                            quantity.text =
                                                                a.toString();

                                                            String price =
                                                                (unitPrice * a)
                                                                    .toStringAsFixed(
                                                                        2);
                                                            controller
                                                                .priceQuantiyUpdater(
                                                                    index:
                                                                        index,
                                                                    quantity:
                                                                        quantity
                                                                            .text,
                                                                    price:
                                                                        price);
                                                          },
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Center(
                                                                child: Icon(
                                                              FontAwesomeIcons
                                                                  .minus,
                                                              color: Colors.grey
                                                                  .shade100,
                                                              size: 10,
                                                            )),
                                                            decoration: BoxDecoration(
                                                                color: AppThemes
                                                                    .modernSexyRed,
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5))),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Container(
                                                          width: 60,
                                                          height: 25,
                                                          color: Colors
                                                              .grey.shade600,
                                                          // decoration: BoxDecoration(
                                                          //     border: Border.all(
                                                          //       color: AppThemes.modernGreen
                                                          //           .withOpacity(0.3),
                                                          //       width: 0.7,
                                                          //     ),
                                                          //     borderRadius:
                                                          //         BorderRadius.circular(8)),

                                                          child: TextField(
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade200),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            textAlign: TextAlign
                                                                .center,
                                                            onChanged: (Value) {
                                                              if (quantity.text
                                                                  .isNotEmpty) {
                                                                if (int.parse(
                                                                        quantity
                                                                            .text) >
                                                                    0) {
                                                                  double unitPrice = controller
                                                                          .cartItems[
                                                                              index]
                                                                          .price! /
                                                                      controller
                                                                          .cartItems[
                                                                              index]
                                                                          .quantity!;

                                                                  String price = (unitPrice *
                                                                          int.parse(quantity
                                                                              .text))
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  controller.priceQuantiyUpdater(
                                                                      index:
                                                                          index,
                                                                      quantity:
                                                                          quantity
                                                                              .text,
                                                                      price:
                                                                          price);
                                                                } else if (int.parse(
                                                                        quantity
                                                                            .text) <=
                                                                    0) {
                                                                  quantity.text =
                                                                      '1';
                                                                  double unitPrice = controller
                                                                          .cartItems[
                                                                              index]
                                                                          .price! /
                                                                      controller
                                                                          .cartItems[
                                                                              index]
                                                                          .quantity!;

                                                                  String price = (unitPrice *
                                                                          int.parse(quantity
                                                                              .text))
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  controller.priceQuantiyUpdater(
                                                                      index:
                                                                          index,
                                                                      quantity:
                                                                          quantity
                                                                              .text,
                                                                      price:
                                                                          price);
                                                                } else {
                                                                  quantity.text =
                                                                      '1';
                                                                  double unitPrice = controller
                                                                          .cartItems[
                                                                              index]
                                                                          .price! /
                                                                      controller
                                                                          .cartItems[
                                                                              index]
                                                                          .quantity!;

                                                                  String price = (unitPrice *
                                                                          int.parse(quantity
                                                                              .text))
                                                                      .toStringAsFixed(
                                                                          2);
                                                                  controller.priceQuantiyUpdater(
                                                                      index:
                                                                          index,
                                                                      quantity:
                                                                          quantity
                                                                              .text,
                                                                      price:
                                                                          price);
                                                                }
                                                              } else {
                                                                quantity.text =
                                                                    '1';
                                                                double unitPrice = controller
                                                                        .cartItems[
                                                                            index]
                                                                        .price! /
                                                                    controller
                                                                        .cartItems[
                                                                            index]
                                                                        .quantity!;

                                                                String price = (unitPrice *
                                                                        int.parse(quantity
                                                                            .text))
                                                                    .toStringAsFixed(
                                                                        2);
                                                                controller.priceQuantiyUpdater(
                                                                    index:
                                                                        index,
                                                                    quantity:
                                                                        quantity
                                                                            .text,
                                                                    price:
                                                                        price);
                                                              }
                                                            },
                                                            controller:
                                                                quantity,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                // borderRadius:
                                                                //     BorderRadius
                                                                //         .circular(5),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppThemes
                                                                      .modernGreen,
                                                                  width: 0.7,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        ZoomTapAnimation(
                                                          onTap: () {
                                                            int a = int.tryParse(
                                                                    quantity
                                                                        .text) ??
                                                                0;
                                                            a++;
                                                            double unitPrice = controller
                                                                    .cartItems[
                                                                        index]
                                                                    .price! /
                                                                int.parse(
                                                                    quantity
                                                                        .text);
                                                            quantity.text =
                                                                a.toString();

                                                            String price =
                                                                (unitPrice * a)
                                                                    .toStringAsFixed(
                                                                        2);
                                                            controller
                                                                .priceQuantiyUpdater(
                                                                    index:
                                                                        index,
                                                                    quantity:
                                                                        quantity
                                                                            .text,
                                                                    price:
                                                                        price);
                                                          },
                                                          child: Container(
                                                            height: 25,
                                                            width: 25,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Center(
                                                                child: Icon(
                                                              FontAwesomeIcons
                                                                  .plus,
                                                              color: Colors.grey
                                                                  .shade100,
                                                              size: 10,
                                                            )),
                                                            decoration: BoxDecoration(
                                                                color: AppThemes
                                                                    .modernGreen,
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5))),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.cartItems[index].price} \n TK",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppThemes.modernCoolPink),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                  // Positioned(
                                  //     right: 17,
                                  //     top: 11,
                                  //     child: ZoomTapAnimation(
                                  //       onTap: () {
                                  //         deleteAlert(
                                  //             controller: controller,
                                  //             index: index);
                                  //       },
                                  //       child: Container(
                                  //         padding: EdgeInsets.all(5),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.grey.shade200,
                                  //             borderRadius: BorderRadius.only(
                                  //                 topRight: Radius.circular(10),
                                  //                 bottomLeft:
                                  //                     Radius.circular(10))),
                                  //         child: Icon(Icons.delete,
                                  //             color: AppThemes.modernCoolPink),
                                  //       ),
                                  //     ))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          height: 80,
                          decoration: BoxDecoration(
                              // color: AppThemes.modernGreen.withOpacity(0.6),
                              border: Border.all(
                                  width: 1, color: AppThemes.modernGreen)
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(20),
                              //     topRight: Radius.circular(20))
                              ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sub total: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    controller.totalPrice.value
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Discount: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500)),
                                Text("0 TK",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total payable: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    controller.totalPrice.value
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade800,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Row(
                            children: [
                              Obx(
                                () => controller.isSaved.value
                                    ? Container()
                                    : Expanded(
                                        flex: 1,
                                        child: ZoomTapAnimation(
                                          onTap: () {
                                            controller.saveOrder();
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: AppThemes.modernBlue),
                                            child: Center(
                                              child: Text(
                                                "SAVE",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              Expanded(
                                flex: 3,
                                child: ZoomTapAnimation(
                                  onTap: () {
                                    controller.requestCheckout();
                                    // beatSelection(controller: controller);
                                    // confirmAlert(controller: controller);
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.maxFinite,
                                    color: AppThemes.modernGreen,
                                    child: Center(
                                      child: Text(
                                        "PLACE ORDER",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              )));
  }

  static deleteAlert(
      {required CartController controller, required int index}) async {
    Get.closeAllSnackbars();
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
          controller.findCartItemIndex(controller.cartItems[index].productId!);
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
                ZoomTapAnimation(
                  onTap: () {
                    controller.reqRemoveFromCart(
                        id: controller.cartItems[index].productId!);
                    Get.back();
                    Get.snackbar(
                        "Item removed!", "The item was removed from your cart!",
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        animationDuration: Duration(seconds: 0),
                        borderRadius: 0,
                        duration: Duration(seconds: 1));
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
                        color: AppThemes.modernGreen,
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

  static beatSelection({required CartController controller}) {
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
                    "Beat selection",
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
                // height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return controller.isBeatLoading.value
                            ? SpinKitThreeBounce(
                                color: AppThemes.modernBlue,
                              )
                            : controller.beatData.isEmpty
                                ? Container()
                                : Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        // color: Colors.blueGrey.shade200,
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade500),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 5),
                                    margin: EdgeInsets.only(top: 10),
                                    width: double.maxFinite,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        isExpanded: true,
                                        alignment: Alignment.center,
                                        value:
                                            controller.dropdownBeatValue.value,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey.shade700,
                                        ),
                                        elevation: 2,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w300),
                                        onChanged: (String? newValue) {
                                          controller.DropdownBeatValueUpdater(
                                              newValue!);
                                        },
                                        items: controller.beatData.value
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                      }),
                      const SizedBox(height: 10),
                      Obx(() {
                        return controller.isCustomerLoading.value
                            ? Container(
                                height: 30,
                                child: SpinKitThreeBounce(
                                  color: AppThemes.modernBlue,
                                ),
                              )
                            : controller.customerData.isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade500),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 5),
                                    margin: EdgeInsets.only(top: 10),
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller: controller
                                              .searchCustomerController,
                                          onChanged: (value) {
                                            Future.delayed(
                                                    Duration(milliseconds: 0))
                                                .then((v) {
                                              controller
                                                  .UpdateFilteredCustomers(
                                                      value);
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Search Customer',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: controller
                                                .dropdownCustomerValue.value,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey.shade700,
                                            ),
                                            elevation: 2,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            onChanged: (String? newValue) {
                                              controller
                                                  .DropdownCustomerValueUpdater(
                                                      newValue!);
                                            },
                                            items: controller.customerData
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                      }),
                    ],
                  ),
                ),
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
                        color: AppThemes.modernGreen,
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
