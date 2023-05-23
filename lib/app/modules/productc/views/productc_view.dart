import 'dart:ffi';
import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sales/app/models/cartproduct.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/productc_controller.dart';

class ProductcView extends GetView<ProductcController> {
  final dynamic argument;
  const ProductcView({Key? key, required this.argument}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int randome = Random().nextInt(7);
    controller.setData(data: argument);

    //final  data=Get.arguments;
    //final String datat=data[0] as String;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 50.0,
            bottomOpacity: 0.0,
            elevation: 0.0,
            titleTextStyle: TextStyle(color: Colors.grey.shade700),
            title: Obx(() => Text(
                "${controller.tempData['type']}" ?? "Products".toUpperCase())),
            actions: [
              Obx(() => controller.isProductLoading.value
                  ? Container(
                      margin: EdgeInsets.only(right: 10),
                      child: SpinKitSpinningLines(
                        color: AppThemes.modernGreen,
                        size: 20,
                      ),
                    )
                  : Container(
                      child: controller.products.isNotEmpty
                          ? Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 40,
                              // width: 50,
                              decoration: BoxDecoration(
                                  color: controller.randomeColor[randome],
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                  child: Text(
                                "Total: ${controller.products.length}",
                                style: TextStyle(
                                    // color: AppThemes.modernSexyRed,
                                    fontWeight: FontWeight.bold),
                              )),
                            )
                          : Container(),
                    ))
            ], //<Widget>[]

            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              // Image.asset("assets/images/back_arrow.jpg"),
              color: Colors.grey.shade700,
              tooltip: 'Click to back',
              onPressed: () {
                Get.back(
                  id: Constants.nestedNavigationNavigatorId,
                );
              },
            )),
        body: SafeArea(
            child: Obx(() => controller.isProductLoading.value
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitDoubleBounce(
                        color: AppThemes.modernGreen,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Fetching product...",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ))
                : controller.products.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Obx(
                              () => !controller.isOffline.value
                                  ? Container()
                                  : Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: AppThemes.modernRed),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .signal_wifi_connected_no_internet_4,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "OFFLINE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.58,
                                  crossAxisCount: _getCrossAxisCount(
                                      context), // Adjusted cross axis count
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                                padding: EdgeInsets.all(10),
                                itemCount: controller.products.length,
                                itemBuilder: (BuildContext context, int i) {
                                  bool status = controller.isAdded.value;
                                  TextEditingController quanity =
                                      TextEditingController(text: "1");
                                  // controller.calculation(price:controller.returnPrice(productCode:  controller.products[i]
                                  //                               ['PRODUCT_CODE']) ,quanity: int.parse(quanity.text));

                                  double unitprice = controller.calculation(
                                      price: controller.returnPrice(
                                          productCode: controller.products[i]
                                              ['PRODUCT_CODE']),
                                      quanity: int.parse(quanity.text));
                                  // controller.countUpdateR(value: i);
                                  print(
                                      "${controller.imageLinkReturn(brand: controller.products[i]['BRAND_NAME'], category: controller.products[i]['CATEGORY'], productid: controller.products[i]['PRODUCT_CODE'])}");
                                  return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: controller
                                                  .randomeColor[randome]),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ZoomTapAnimation(
                                              onTap: () {
                                                Get.toNamed(Routes.PRODUCTINFO,
                                                    arguments:
                                                        controller.products[i],
                                                    id: Constants
                                                        .nestedNavigationNavigatorId);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 20, left: 20),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: controller
                                                            .randomeColor[
                                                                randome]
                                                            .withOpacity(0.3)),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15))),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  14),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  14)),
                                                  child: CachedNetworkImage(
                                                    width: double.maxFinite,
                                                    imageUrl:
                                                        // "",
                                                        controller.imageLinkReturn(
                                                            brand: controller
                                                                    .products[i]
                                                                ['BRAND_NAME'],
                                                            category: controller
                                                                    .products[i]
                                                                ['CATEGORY'],
                                                            productid: controller
                                                                    .products[i]
                                                                [
                                                                'PRODUCT_CODE']),
                                                    // height: 160,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                SpinKitThreeBounce(
                                                      color: controller
                                                              .randomeColor[
                                                          randome],
                                                    )),
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
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${controller.products[i]['PRODUCT_NAME']}"
                                                                .toString()
                                                                .length >
                                                            15
                                                        ? "${controller.products[i]['PRODUCT_NAME']}"
                                                                .toString()
                                                                .substring(
                                                                    0, 15) +
                                                            "..."
                                                        : "${controller.products[i]['PRODUCT_NAME']}"
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Variant: ${controller.products[i]['VARIANT']}",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        // fontWeight:
                                                        //     FontWeight.w500,
                                                        fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "Size: ${controller.products[i]['WEIGHT_SIZE']}",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade500,
                                                        // fontWeight:
                                                        // FontWeight.w500,
                                                        fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Text(
                                                    "${'${controller.returnPrice(productCode: '${controller.products[i]['PRODUCT_CODE']}')} Tk'}",
                                                    style: TextStyle(
                                                        color: controller
                                                                .randomeColor[
                                                            randome],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.center,
                                                  ),
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
                                                                  quanity
                                                                      .text) ??
                                                              0;
                                                          if (a > 1) {
                                                            a--;
                                                          } else {
                                                            a = 1;
                                                          }
                                                          if (int.parse(quanity
                                                                      .text) -
                                                                  1 ==
                                                              0) {
                                                            quanity.text = "1";
                                                          }

                                                          quanity.text =
                                                              a.toString();
                                                          controller.calculation(
                                                              price: double.parse(controller
                                                                  .returnPrice(
                                                                      productCode:
                                                                          '${controller.products[i]['PRODUCT_CODE']}')
                                                                  .toString()),
                                                              quanity: a);
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Center(
                                                              child: Icon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            color: Colors
                                                                .grey.shade800,
                                                            size: 10,
                                                          )),
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          5))),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 20,
                                                        child: TextField(
                                                          onChanged: (value) {
                                                            if (quanity.text
                                                                .isNotEmpty) {
                                                              if (int.parse(
                                                                      quanity
                                                                          .text) >
                                                                  0) {
                                                                controller.calculation(
                                                                    price: double.parse(controller
                                                                        .returnPrice(
                                                                            productCode:
                                                                                '${controller.products[i]['PRODUCT_CODE']}')
                                                                        .toString()),
                                                                    quanity: int
                                                                        .parse(quanity
                                                                            .text));
                                                              } else if (int.parse(
                                                                      quanity
                                                                          .text) <=
                                                                  0) {
                                                                quanity.text =
                                                                    '1';
                                                                controller.calculation(
                                                                    price: double.parse(controller
                                                                        .returnPrice(
                                                                            productCode:
                                                                                '${controller.products[i]['PRODUCT_CODE']}')
                                                                        .toString()),
                                                                    quanity: int
                                                                        .parse(quanity
                                                                            .text));
                                                              } else {
                                                                quanity.text =
                                                                    '1';
                                                                controller.calculation(
                                                                    price: double.parse(controller
                                                                        .returnPrice(
                                                                            productCode:
                                                                                '${controller.products[i]['PRODUCT_CODE']}')
                                                                        .toString()),
                                                                    quanity: int
                                                                        .parse(quanity
                                                                            .text));
                                                              }
                                                            } else {
                                                              quanity.text =
                                                                  '1';
                                                              controller.calculation(
                                                                  price: double.parse(controller
                                                                      .returnPrice(
                                                                          productCode:
                                                                              '${controller.products[i]['PRODUCT_CODE']}')
                                                                      .toString()),
                                                                  quanity: int
                                                                      .parse(quanity
                                                                          .text));
                                                            }
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          textAlign:
                                                              TextAlign.center,
                                                          controller: quanity,
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle:
                                                                TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      ZoomTapAnimation(
                                                        onTap: () {
                                                          int a = int.tryParse(
                                                                  quanity
                                                                      .text) ??
                                                              0;
                                                          a++;
                                                          quanity.text =
                                                              a.toString();
                                                          controller.calculation(
                                                              price: double.parse(controller
                                                                  .returnPrice(
                                                                      productCode:
                                                                          '${controller.products[i]['PRODUCT_CODE']}')
                                                                  .toString()),
                                                              quanity: a);
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child: Center(
                                                              child: Icon(
                                                            FontAwesomeIcons
                                                                .plus,
                                                            color: Colors
                                                                .grey.shade800,
                                                            size: 10,
                                                          )),
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          5),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          5))),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Obx(() => ZoomTapAnimation(
                                                        onTap:
                                                            controller.isAdded
                                                                    .value
                                                                ? () {}
                                                                : () {
                                                                    CartItem
                                                                        product =
                                                                        CartItem(
                                                                      userId: 1,
                                                                      productId:
                                                                          controller.products[i]
                                                                              [
                                                                              "SKU_CODE"],
                                                                      customerName:
                                                                          "",
                                                                      beatName:
                                                                          "",
                                                                      productName:
                                                                          controller.products[i]
                                                                              [
                                                                              "PRODUCT_NAME"],
                                                                      catagory:
                                                                          controller.products[i]
                                                                              [
                                                                              "CATEGORY"],
                                                                      unit: controller
                                                                              .products[i]
                                                                          [
                                                                          "UOM"],
                                                                      image:
                                                                          "https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Red-Carpet-Lip-Color-02-Florida.png",
                                                                      price: controller.calculation(
                                                                          price: double.parse(controller
                                                                              .returnPrice(productCode: '${controller.products[i]['PRODUCT_CODE']}')
                                                                              .toString()),
                                                                          quanity: int.parse(quanity.text)),
                                                                      brand: controller
                                                                              .products[i]
                                                                          [
                                                                          "BRAND_NAME"],
                                                                      quantity:
                                                                          int.parse(quanity.text) ??
                                                                              1,
                                                                      unitPrice:
                                                                          controller.returnPrice(
                                                                              productCode: '${controller.products[i]['PRODUCT_CODE']}'),
                                                                    );
                                                                    controller
                                                                        .addToCart(
                                                                            data:
                                                                                product);

                                                                    // addAlert(controller: controller, data: i);
                                                                  },
                                                        child: Container(
                                                          height: 30,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: controller
                                                                      .randomeColor[
                                                                  randome]),
                                                          child: Center(
                                                            child: Text(
                                                              "Add to cart",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                ],
                                              ))
                                        ],
                                      ));
                                  ;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/emptycart.png",
                                height: 200,
                              ),
                              Text(
                                "No products found!",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ))));
  }

  // static addAlert(
  //     {required ProductcController controller, required dynamic data}) {
  //   Get.generalDialog(
  //       transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
  //             filter: ImageFilter.blur(
  //               sigmaX: 4 * anim1.value,
  //               sigmaY: 4 * anim1.value,
  //             ),
  //             child: FadeTransition(
  //               child: child,
  //               opacity: anim1,
  //             ),
  //           ),
  //       pageBuilder: (ctx, anim1, anim2) {
  //         TextEditingController quanity = TextEditingController();
  //         quanity.text = 1.toString();

  //         return MediaQuery(
  //           data: MediaQuery.of(ctx).copyWith(textScaleFactor: 1.0),
  //           child: AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20)),
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "Enter Quantity:",
  //                   style: TextStyle(),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     Get.back();
  //                   },
  //                   child: Container(
  //                     padding: EdgeInsets.all(5),
  //                     child: Center(
  //                         child: Icon(
  //                       Icons.close,
  //                       color: Colors.red.shade800,
  //                       size: 20,
  //                     )),
  //                     decoration: BoxDecoration(
  //                         color: Colors.grey.shade200,
  //                         borderRadius: BorderRadius.circular(100)),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             content: Container(
  //               height: 80,
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       ZoomTapAnimation(
  //                         onTap: () {
  //                           int a = int.tryParse(quanity.text) ?? 0;
  //                           if (a == 0) {
  //                           } else {
  //                             a--;
  //                           }

  //                           quanity.text = a.toString();
  //                           controller.calculation(
  //                               price: double.parse(data["price"].toString()),
  //                               quanity: a);
  //                         },
  //                         child: Container(
  //                           height: 40,
  //                           width: 40,
  //                           padding: EdgeInsets.all(5),
  //                           child: Center(
  //                               child: Icon(
  //                             FontAwesomeIcons.minus,
  //                             color: Colors.grey.shade800,
  //                             size: 15,
  //                           )),
  //                           decoration: BoxDecoration(
  //                               color: Colors.grey.shade200,
  //                               borderRadius: BorderRadius.circular(100)),
  //                         ),
  //                       ),
  //                       Container(
  //                         width: 80,
  //                         height: 50,
  //                         child: TextField(
  //                           controller: quanity,
  //                           decoration: InputDecoration(
  //                             hintStyle: TextStyle(
  //                               color: Colors.black,
  //                             ),
  //                             border: OutlineInputBorder(
  //                               borderRadius: BorderRadius.circular(15),
  //                               borderSide: BorderSide(
  //                                 color: Colors.grey.shade400,
  //                                 width: 1,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       ZoomTapAnimation(
  //                         onTap: () {
  //                           int a = int.tryParse(quanity.text) ?? 0;
  //                           a++;
  //                           quanity.text = a.toString();
  //                           controller.calculation(
  //                               price: double.parse(data["price"].toString()),
  //                               quanity: a);
  //                         },
  //                         child: Container(
  //                           height: 40,
  //                           width: 40,
  //                           padding: EdgeInsets.all(5),
  //                           child: Center(
  //                               child: Icon(
  //                             FontAwesomeIcons.plus,
  //                             color: Colors.grey.shade800,
  //                             size: 15,
  //                           )),
  //                           decoration: BoxDecoration(
  //                               color: Colors.grey.shade200,
  //                               borderRadius: BorderRadius.circular(100)),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Obx(() => Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             "Total price: " +
  //                                 controller.totalPrice.value.toString(),
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.w500, fontSize: 18),
  //                           )
  //                         ],
  //                       ))
  //                 ],
  //               ),
  //             ),
  //             actionsPadding: EdgeInsets.all(10),
  //             actions: [
  //               InkWell(
  //                 onTap: () {
  //                   if (int.parse(quanity.text) > 0) {
  //                     Get.back();
  //                     CartItem product = CartItem(
  //                         userId: 1,
  //                         productId: data["productId"],
  //                         customerName: "",
  //                         beatName: "",
  //                         productName: data["name"],
  //                         catagory: data["catagory"],
  //                         unit: data["unit"],
  //                         image: data["img"],
  //                         price: data["price"],
  //                         brand: data["brand"],
  //                         quantity: int.parse(quanity.text),
  //                         unitPrice: data["price"]);
  //                     controller.addToCart(data: product);
  //                   }
  //                 },
  //                 child: Container(
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       color: Colors.green.shade500,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   alignment: Alignment.center,
  //                   child: Text("Add", style: TextStyle(color: Colors.white)),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}

int _getCrossAxisCount(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final itemWidth = 200; // Adjust this value based on your item's width
  final crossAxisCount = (screenWidth / itemWidth).floor();
  if (crossAxisCount == 1) {
    return 2;
  } else {
    return crossAxisCount;
  }
}
// {"orderId": "ORD68136",
//  "lattitude": 37.4220936,
//  "longitude": -122.083922,
//   "totalItemCount": 3,
//  "dateTime": "2023-05-08 12:33:19.700091",
//  "totalPrice": "3280.0", "beatName":" Kothakoli Market",
//  "CustomerName": "Fashoin Word",
//   "items":
//   [
//     {
//       "brand": NIOR,
//     "productId": "NRCC-2001-DESCH",
//     "quantity": 2,
//     "totalPrice": 3280.0,
//     "unitPrice": 820.0
//     },

//    {
//     "brand": "NIOR",
//    "productId": "NRCC-3105-KRHLB",
//    "quantity": 1,
//    "totalPrice": 820.0,
//    "unitPrice": 820.0
//    },
//    {
//     "brand": "HERLAN",
//     "productId": "HNCC-1004-DEFBC",
//      "quantity": 1,
//       "totalPrice": 820.0,
//        "unitPrice": 820.0
//        }
//        ]}
