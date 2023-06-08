import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/sync/products/offlineordersync.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants.dart';
import '../../../models/saleRequisition.dart';
import '../../../routes/app_pages.dart';
import '../controllers/order_home_controller.dart';

class OrderHomeView extends GetView<OrderHomeController> {
  OrderHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List brands = [
      'acnol',
      'blazoskin',
      'elanvenezia',
      'tylox',
      'herlan',
      'lily',
      'nior',
      'orix',
      'siodil',
      'sunbit',
    ];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String? selectedValue;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: COMMONWIDGET.globalAppBar(
            tittle: "Order management",
            backFunction: () => Get.back(
                  result: controller.count.value,
                  id: Constants.nestedNavigationNavigatorId,
                )),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => controller.offlineOrderCount.value == 0
                        ? Container()
                        : Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: AppThemes.modernRed,
                                border: Border.all(
                                    width: .8, color: AppThemes.modernRed),
                                borderRadius: BorderRadius.circular(5)),
                            // height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${controller.offlineOrderCount.value} ORDERS WAITING TO BE SYNCED",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: ZoomTapAnimation(
                                    onTap: () {
                                      OFFLINEORDERSYNC().onlineSync();
                                      controller.offlineOrderCount();
                                    },
                                    child: Container(
                                      height: 40,
                                      // width: 50,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Text("SYNC NOW"),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return controller.isBeatLoading.value
                        ? Container(
                            height: 30,
                            child: SpinKitRipple(
                              color: AppThemes.modernGreen,
                            ),
                          )
                        : controller.beatData[0] == ""
                            ? Container()
                            : Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    // color: Colors.blueGrey.shade200,
                                    border: Border.all(
                                        width: 1, color: Colors.grey.shade500),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 5),
                                margin: EdgeInsets.only(top: 10),
                                width: double.maxFinite,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    alignment: Alignment.center,
                                    value: controller.dropdownBeatValue.value,
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
                            child: SpinKitRipple(
                              color: AppThemes.modernGreen,
                            ),
                          )
                        : controller.customerData[0] == ""
                            ? Container()
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 5),
                                margin: EdgeInsets.only(top: 10),
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller:
                                          controller.searchCustomerController,
                                      onChanged: (value) {
                                        Future.delayed(
                                                Duration(milliseconds: 500))
                                            .then((v) {
                                          controller.UpdateFilteredCustomers(
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
                  const SizedBox(height: 20),
                  Obx(
                    () => controller.isReorderCompleted.value
                        ? Container()
                        : controller.itemList.length == 0
                            ? Container()
                            : Row(
                                children: [
                                  Text(
                                    'Last order',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                  ),
                  const SizedBox(height: 10),
                  //---------------------Last order option---------------//

                  Obx(
                    () => controller.isReorderCompleted.value
                        ? Container()
                        : controller.isReorder.value
                            ? Container(
                                height: 250,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: AppThemes.modernGreen,
                                    border:
                                        Border.all(color: Colors.grey.shade500),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.check,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                                      Text(
                                        'Products added to cart!',
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.grey.shade100),
                                      ),
                                    ]),
                              )
                            : controller.itemList.isEmpty
                                ? Container()
                                : ZoomTapAnimation(
                                    onTap: () {
                                      // controller.addAllToCart();
                                      confirmAlert(controller: controller);
                                    },
                                    child: Container(
                                      height: 250,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: controller.itemList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            height: 80,
                                            width: 250,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        AppThemes.modernGreen),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15))),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        13),
                                                                topRight: Radius
                                                                    .circular(
                                                                        13)),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppThemes
                                                                .modernGreen)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(13),
                                                              topRight: Radius
                                                                  .circular(
                                                                      13)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .itemList[index]
                                                            .image
                                                            .toString(),
                                                        // height: 160,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget:
                                                            (ctx, url, err) =>
                                                                Image.asset(
                                                          'assets/images/noprev.png',
                                                          height: 70,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                                    .itemList[
                                                                        index]
                                                                    .productName
                                                                    .toString()
                                                                    .length >
                                                                15
                                                            ? controller
                                                                .itemList[index]
                                                                .productName
                                                                .toString()
                                                                .substring(
                                                                    0, 15)
                                                            : controller
                                                                .itemList[index]
                                                                .productName
                                                                .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                          controller
                                                              .itemList[index]
                                                              .catagory
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14)),
                                                      Text(
                                                          controller
                                                              .itemList[index]
                                                              .brand
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14)),
                                                      Text(
                                                          "Quantity: ${controller.itemList[index].quantity}",
                                                          style: TextStyle(
                                                              fontSize: 14)),
                                                      Text(
                                                        '${controller.itemList[index].price.toString()} Tk',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => controller.saveItem.isEmpty
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                'Saved orders',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                  ),
                  Obx(
                    () => controller.saveItem.isEmpty
                        ? Container()
                        : SizedBox(
                            height: 10,
                          ),
                  ),

                  Obx(
                    () => controller.saveItem.length == 0
                        ? Container()
                        : Container(
                            height: 250,
                            width: double.maxFinite,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.saveItem.length,
                                itemBuilder: (context, index) {
                                  DateFormat formatter = new DateFormat.jm();
                                  String time = formatter.format(DateTime.parse(
                                      "${controller.saveItem[index].dateTime.toString().split(".")[0]}"));
                                  return ZoomTapAnimation(
                                    onLongTap: () {
                                      deleteAlert(
                                          index: index, controller: controller);
                                    },
                                    onTap: () async {
                                      await controller.reqSavedItemsList(
                                          saveId: controller
                                                  .saveItem[index].saveId ??
                                              "");

                                      if (controller.savedItems.isNotEmpty) {
                                        savedOrderItemShow(
                                            controller: controller);
                                      }
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 250,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 0.8,
                                              color: AppThemes.modernGreen)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              "${index + 1} | ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Save ID: ${controller.saveItem[index].saveId}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Total price: ${controller.saveItem[index].totalPrice}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Save date: ${controller.saveItem[index].dateTime.toString().split(".")[0].split(" ")[0]}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Save time: ${time}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration: BoxDecoration(
                                                            color: AppThemes
                                                                .modernGreen),
                                                        child: Center(
                                                          child: Text(
                                                            "${controller.saveItem[index].totalItem} items",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Tap and Hold to remove",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Our brands',
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 300,
                    // decoration: BoxDecoration(
                    //     // color: Colors.blueGrey.shade200,
                    //     border: Border.all(width: 1, color: Colors.grey.shade500),
                    //     borderRadius: BorderRadius.circular(10)),
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      children: List.generate(10, (index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.PRODUCTB,
                                arguments: {"brand": brands[index]},
                                id: Constants.nestedNavigationNavigatorId);
                            // Get.toNamed(Routes.PRODUCTC,
                            //     arguments: index.toString(),
                            //     id: Constants.nestedNavigationNavigatorId);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                // borderRadius: BorderRadius.only(
                                //     topLeft: Radius.circular(15),
                                //     bottomRight: Radius.circular(15)
                                //     ),
                                border: Border.all(
                                    width: 1, color: AppThemes.modernGreen)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: AssetImage("assets/images/${index}.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true, //beauty and cosmetic
                    itemCount: controller.bottomMenu.length,
                    itemBuilder: (BuildContext context, int index) {
                      int random = Random().nextInt(5);
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        // height: 60,
                        width: double.maxFinite,
                        decoration: BoxDecoration(),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  color: controller.randomeColor[random],
                                  border: Border.all(
                                      color: Colors.grey.shade100, width: 1)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    bottomLeft: Radius.circular(14)),
                                child: CachedNetworkImage(
                                  imageUrl: controller.bottomMenu[index]
                                      ['icon'],
                                  // height: 160,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: SpinKitRipple(
                                    color: AppThemes.modernGreen,
                                    size: 50.0,
                                  )),
                                  errorWidget: (ctx, url, err) => Image.asset(
                                    controller.bottomMenu[index]['icon'],
                                    height: 70,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  // color: AppThemes.modernGreen,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.bottomMenu[index]['title'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              controller.randomeColor[random]),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  static confirmAlert({required OrderHomeController controller}) {
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
                child: Text("Are you sure to palce this order again?"),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.addAllToCart();
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

  static savedOrderItemShow({required OrderHomeController controller}) {
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
                  height: 400,
                  width: double.maxFinite,
                  child: ListView.builder(
                      itemCount: controller.savedItems.length,
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
                                    imageUrl: controller.savedItems[index].image
                                        .toString(),
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
                                        "${controller.savedItems[index].productName}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "ID:${controller.savedItems[index].productId}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${controller.savedItems[index].brand}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Quantity: ${controller.savedItems[index].quantity}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Price: ${controller.savedItems[index].price}",
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
                    controller.addAllSavedToCart();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppThemes.modernGreen,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text("Add to cart",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }

  static deleteAlert(
      {required int index, required OrderHomeController controller}) {
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
                child: Text("Are you sure remove this from your saved list?"),
              ),
              actionsPadding: EdgeInsets.all(10),
              actions: [
                InkWell(
                  onTap: () {
                    Get.back();
                    controller.removeSavedItem(index: index);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppThemes.modernSexyRed,
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child:
                        Text("Remove", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          );
        });
  }
}
