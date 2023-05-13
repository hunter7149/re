import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../components/custom_dropdown.dart';
import '../../../config/app_assets.dart';
import '../../../data/menus.dart';
import '../../../models/menu.dart';
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
                  Obx(() {
                    return controller.beatData.isEmpty
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
                    return controller.customerList.isEmpty
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
                                value: controller.dropdownCustomerValue.value,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey.shade700,
                                ),
                                elevation: 2,
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w300),
                                onChanged: (String? newValue) {
                                  controller.DropdownCustomerValueUpdater(
                                      newValue!);
                                },
                                items: controller.customerList.value
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
                                    color: Colors.green.shade300,
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
                                : Column(
                                    children: [
                                      ZoomTapAnimation(
                                        onTap: () {
                                          // controller.addAllToCart();
                                          confirmAlert(controller: controller);
                                        },
                                        child: Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.itemList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                height: 80,
                                                width: 150,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppThemes
                                                            .modernGreen),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        width: double.maxFinite,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.only(
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
                                                                      .circular(
                                                                          13),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          13)),
                                                          child:
                                                              CachedNetworkImage(
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
                                                            errorWidget: (ctx,
                                                                    url, err) =>
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
                                                                    .itemList[
                                                                        index]
                                                                    .productName
                                                                    .toString()
                                                                    .substring(
                                                                        0, 15)
                                                                : controller
                                                                    .itemList[
                                                                        index]
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
                                                                  .itemList[
                                                                      index]
                                                                  .catagory
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              controller
                                                                  .itemList[
                                                                      index]
                                                                  .brand
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                            'Unit Tk ${controller.itemList[index].price.toString()}',
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
                                      // InkWell(
                                      //   onTap: () {
                                      //     controller.addAllToCart();
                                      //   },
                                      //   child: Container(
                                      //     height: 50,
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.green.shade300,
                                      //         ./÷/// // border: Border.all(color: Colors.grey.shade500),
                                      //         borderRadius: BorderRadius.only(
                                      //             bottomLeft: Radius.circular(10),
                                      //             bottomRight:
                                      //                 Radius.circular(10))),
                                      //     child: Center(
                                      //         child: Text(
                                      //       "ADD TO CART",
                                      //       style: TextStyle(
                                      //           fontSize: 20,
                                      //           fontWeight: FontWeight.w500,
                                      //           color: Colors.white),
                                      //     )),
                                      //   ),
                                      // )
                                    ],
                                  ),
                  ),
                  SizedBox(height: 10),
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
}
