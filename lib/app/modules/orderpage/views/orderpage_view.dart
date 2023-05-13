import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../models/saleRequisition.dart';
import '../controllers/orderpage_controller.dart';

class OrderpageView extends GetView<OrderpageController> {
  const OrderpageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Order List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.orderItem.isEmpty
          ? Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/emptycart.png",
                      height: 200,
                    ),
                    Text("You have no orders!"),
                  ],
                ),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.orderItem.length,
                          itemBuilder: (context, index) {
                            DateFormat formatter = new DateFormat.jm();
                            String time = formatter.format(DateTime.parse(
                                "${controller.orderItem[index].dateTime.toString().split(".")[0]}"));
                            return ZoomTapAnimation(
                              onTap: () {
                                controller.reqOrderedItemsList(
                                    orderId:
                                        controller.orderItem[index].orderId ??
                                            "");
                                confirmAlert(data: controller.itemList);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.8,
                                        color: Colors.grey.shade400)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${index + 1} | ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Order ID: ${controller.orderItem[index].orderId}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        space(),
                                        Text(
                                          "Total price: ${controller.orderItem[index].totalPrice}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        space(),
                                        Text(
                                          "Order date: ${controller.orderItem[index].dateTime.toString().split(".")[0].split(" ")[0]}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        space(),
                                        Text(
                                          "Order time: ${time}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        space(),
                                        Text(
                                          "Beat name: ${controller.orderItem[index].beatName}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        space(),
                                        Text(
                                          "Customer name: ${controller.orderItem[index].CustomerName}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        space(),
                                        Row(
                                          children: [
                                            Text(
                                              "Status: ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrange),
                                              child: Text(
                                                "${controller.orderItem[index].status}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total Items",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            textAlign: TextAlign.center,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            margin: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Center(
                                              child: Text(
                                                "${controller.orderItem[index].totalItem}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ),
            )),
    );
  }

  static space() {
    return Container(
      height: 2,
    );
  }

  static confirmAlert({required RxList<SaleRequisition> data}) {
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
                  borderRadius: BorderRadius.circular(10)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Items",
                    style: TextStyle(),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(5),
                  //     child: Center(
                  //         child: Icon(
                  //       Icons.close,
                  //       color: Colors.red.shade800,
                  //       size: 20,
                  //     )),
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey.shade200,
                  //         borderRadius: BorderRadius.circular(100)),
                  //   ),
                  // )
                ],
              ),
              content: Container(
                  height: 400,
                  width: double.maxFinite,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          // height: 10,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.7, color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                // flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  // borderRadius: BorderRadius.only(
                                  //     topRight: Radius.circular(15),
                                  //     bottomRight: Radius.circular(15)
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl: data[index].image.toString(),
                                    // height: 160,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (ctx, url, err) => Image.asset(
                                      'assets/images/noprev.png',
                                      height: 70,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[index].productName}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "ID:${data[index].productId}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${data[index].brand}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Quantity: ${data[index].quantity}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Price: ${data[index].price}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        );
                      })),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text("Okay", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }
}
