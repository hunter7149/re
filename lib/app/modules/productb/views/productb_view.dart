import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../api/service/prefrences.dart';
import '../../../models/cartproduct.dart';
import '../../../routes/app_pages.dart';
import '../controllers/productb_controller.dart';

class ProductbView extends GetView<ProductbController> {
  final dynamic argument;
  ProductbView({
    Key? key,
    this.argument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int randome = Random().nextInt(7);
    controller.dataSetter(argument);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: COMMONWIDGET.globalAppBar(
          tittle: "Product Catalogue",
          backEnabled: true,
          backFunction: () {
            Get.back(
              // result: controller..products.length,
              id: Constants.nestedNavigationNavigatorId,
            );
          }),
      body: Obx(() => controller.isProductsLoading.value
          ? SpinKitDoubleBounce(
              color: AppThemes.modernGreen,
            )
          : controller.products.isEmpty
              ? Center(
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
                )))
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (BuildContext, index) {
                        // String key = controller.products.keys.elementAt(index);
                        return productByBrandBlock(
                            controller: controller,
                            index: index,
                            randome: randome,
                            argument: argument);
                      }),
                )),
    );
  }
}

productByBrandBlock(
    {required ProductbController controller,
    required int index,
    required int randome,
    required dynamic argument}) {
  String key = controller.products.keys.elementAt(index);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    // height: 400,
    width: double.maxFinite,
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${key}",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 20),
            ),
            // ZoomTapAnimation(
            //   onTap: () {
            //     Get.toNamed(Routes.PRODUCTC,
            //         arguments: {
            //           "brand": "${argument['brand']}",
            //           "type": "${key}"
            //         },
            //         id: Constants.nestedNavigationNavigatorId);
            //   },
            //   child: Text(
            //     "View all",
            //     style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        productViewFromList(
            controller: controller,
            category: key,
            brandIndex: index,
            randome: randome,
            argument: argument),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

productViewFromList(
    {required ProductbController controller,
    required String category,
    required int brandIndex,
    required int randome,
    required dynamic argument}) {
  return Container(
      height: 320,
      // width: 200,
      // decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(width: 1, color: controller.randomeColor[randome]),
      //     borderRadius: BorderRadius.circular(8)),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products[category].length > 11
              ? 11
              : controller.products[category].length,
          itemBuilder: (BuildContext, index) {
            if (index == 10 && controller.products[category].length > 11) {
              // Display "View All" button at index 10 if there are more than 10 items
              return ZoomTapAnimation(
                onTap: () {
                  Get.toNamed(Routes.PRODUCTC,
                      arguments: {
                        "brand": "${argument['brand']}",
                        "type": "${category}"
                      },
                      id: Constants.nestedNavigationNavigatorId);
                },
                child: Container(
                  height: 280,
                  width: 200,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: controller.randomeColor[randome],
                    border: Border.all(
                      width: 1,
                      color: controller.randomeColor[randome],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    offset: Offset(-4, -2),
                                    spreadRadius: 1,
                                    blurRadius: 5),
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: Offset(4, 2),
                                    spreadRadius: 1,
                                    blurRadius: 5),
                              ],
                              borderRadius: BorderRadius.circular(100),
                              color: controller.randomeColor[randome]),
                          child: Center(
                            child: Icon(
                              Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              TextEditingController quanity = TextEditingController(text: "1");
              String price = controller.getSellPriceByProductCode(
                      productCode: controller.products[category][index]
                              ['PRODUCT_CODE']
                          .toString(),
                      orgCode: controller.products[category][index]['ORG_CODE']
                          .toString()) ??
                  controller.products[category][index]['MPR'].toString();
              return Container(
                height: 280,
                width: 200,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1, color: controller.randomeColor[randome]),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ZoomTapAnimation(
                          onTap: () {
                            Get.toNamed(Routes.PRODUCTINFO,
                                arguments: controller.products[category][index],
                                id: Constants.nestedNavigationNavigatorId);
                          },
                          child: Container(
                            // height: 120,
                            margin: EdgeInsets.only(top: 20, left: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: controller.randomeColor[randome]
                                        .withOpacity(0.3)),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  bottomLeft: Radius.circular(14)),
                              child: CachedNetworkImage(
                                width: double.maxFinite,
                                imageUrl: "",
                                // controller.imageLinkReturn(
                                //     brand: controller.products[i]['BRAND_NAME'],
                                //     category: controller.products[i]['CATEGORY'],
                                //     productid: controller.products[i]['PRODUCT_CODE']),
                                // height: 160,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: SpinKitThreeBounce(
                                  color: controller.randomeColor[randome],
                                )),
                                errorWidget: (ctx, url, err) => Image.asset(
                                  'assets/images/noprevvec.jpg',
                                  height: 120,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${controller.products[category][index]['PRODUCT_NAME']}"
                                          .toString()
                                          .length >
                                      15
                                  ? "${controller.products[category][index]['PRODUCT_NAME']}"
                                          .toString()
                                          .substring(0, 15) +
                                      "..."
                                  : "${controller.products[category][index]['PRODUCT_NAME']}"
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Variant: ${controller.products[category][index]['VARIANT'].toString().length > 15 ? "${controller.products[category][index]['VARIANT']}".toString().substring(0, 15) + "..." : controller.products[category][index]['VARIANT']}",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    // fontWeight:
                                    //     FontWeight.w500,
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "Size: ${controller.products[category][index]['WEIGHT_SIZE']}",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  // fontWeight:
                                  // FontWeight.w500,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              // "${'${controller.returnPrice(productCode: '${controller.       products[category][index]['PRODUCT_CODE']}')} Tk'}",
                              "${price} TK",
                              style: TextStyle(
                                  color: controller.randomeColor[randome],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ZoomTapAnimation(
                                  onTap: () {
                                    int a = int.tryParse(quanity.text) ?? 0;
                                    if (a > 1) {
                                      a--;
                                    } else {
                                      a = 1;
                                    }
                                    if (int.parse(quanity.text) - 1 == 0) {
                                      quanity.text = "1";
                                    }

                                    quanity.text = a.toString();
                                    controller.calculation(
                                        price: double.parse("${price}"),
                                        quanity: a);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 40,
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                        child: Icon(
                                      FontAwesomeIcons.minus,
                                      color: Colors.grey.shade800,
                                      size: 10,
                                    )),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5))),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 60,
                                  height: 30,
                                  child: TextField(
                                    onChanged: (value) {
                                      if (quanity.text.isNotEmpty) {
                                        if (int.parse(quanity.text) > 0) {
                                          controller.calculation(
                                              price: double.parse('${price}'),
                                              quanity: int.parse(quanity.text));
                                        } else if (int.parse(quanity.text) <=
                                            0) {
                                          quanity.text = '1';
                                          controller.calculation(
                                              price: double.parse('${price}'),
                                              quanity: int.parse(quanity.text));
                                        } else {
                                          quanity.text = '1';
                                          controller.calculation(
                                              price: double.parse('${price}'),
                                              quanity: int.parse(quanity.text));
                                        }
                                      } else {
                                        quanity.text = '1';
                                        controller.calculation(
                                            price: double.parse('${price}'),
                                            quanity: int.parse(quanity.text));
                                      }
                                    },
                                    style: TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.center,
                                    controller: quanity,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(2),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
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
                                    int a = int.tryParse(quanity.text) ?? 0;
                                    a++;
                                    quanity.text = a.toString();
                                    controller.calculation(
                                        price: double.parse('${price}'),
                                        quanity: a);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 40,
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                        child: Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.grey.shade800,
                                      size: 10,
                                    )),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                  ),
                                ),
                              ],
                            ),
                            Obx(() => ZoomTapAnimation(
                                  onTap: controller.isAdded.value
                                      ? () {}
                                      : () {
                                          CartItem product = CartItem(
                                            userId:
                                                "${Pref.readData(key: Pref.USER_ID)}",
                                            productId:
                                                controller.products[category]
                                                    [index]["SKU_CODE"],
                                            customerName:
                                                "${controller.customerId.value}",
                                            beatName: "",
                                            productName:
                                                controller.products[category]
                                                    [index]["PRODUCT_NAME"],
                                            catagory:
                                                controller.products[category]
                                                    [index]["CATEGORY"],
                                            unit: controller.products[category]
                                                [index]["UOM"],
                                            image:
                                                "https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Red-Carpet-Lip-Color-02-Florida.png",
                                            price: controller.calculation(
                                                price: double.parse('${price}'),
                                                quanity:
                                                    int.parse(quanity.text)),
                                            brand: controller.products[category]
                                                [index]["BRAND_NAME"],
                                            quantity:
                                                int.parse(quanity.text) ?? 1,
                                            unitPrice: double.parse('${price}'),
                                          );
                                          controller.addToCart(data: product);
                                        },
                                  child: Container(
                                    height: 40,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            controller.randomeColor[randome]),
                                    child: Center(
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }));
}
// productItemView({required ProductbController controller, required int index,required int randome}) {
//   bool status = controller.isAdded.value;
//   TextEditingController quanity = TextEditingController(text: "1");
//   // controller.calculation(price:controller.returnPrice(productCode:  controller.products[i]
//   //                               ['PRODUCT_CODE']) ,quanity: int.parse(quanity.text));

//   double unitprice = controller.calculation(
//       price: controller.returnPrice(
//           productCode: controller.products[i]['PRODUCT_CODE']),
//       quanity: int.parse(quanity.text));
//   // controller.countUpdateR(value: i);
//   print(
//       "${controller.imageLinkReturn(brand: controller.products[i]['BRAND_NAME'], category: controller.products[i]['CATEGORY'], productid: controller.products[i]['PRODUCT_CODE'])}");
//   return Container(
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(width: 1, color: controller.randomeColor[randome]),
//           borderRadius: BorderRadius.circular(8)),
//       child: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: ZoomTapAnimation(
//               onTap: () {
//                 Get.toNamed(Routes.PRODUCTINFO,
//                     arguments: controller.products[i],
//                     id: Constants.nestedNavigationNavigatorId);
//               },
//               child: Container(
//                 margin: EdgeInsets.only(top: 20, left: 20),
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                         width: 1,
//                         color:
//                             controller.randomeColor[randome].withOpacity(0.3)),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         bottomLeft: Radius.circular(15))),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(14),
//                       bottomLeft: Radius.circular(14)),
//                   child: CachedNetworkImage(
//                     width: double.maxFinite,
//                     imageUrl:
//                         "",
//                         // controller.imageLinkReturn(
//                         //     brand: controller.products[i]['BRAND_NAME'],
//                         //     category: controller.products[i]['CATEGORY'],
//                         //     productid: controller.products[i]['PRODUCT_CODE']),
//                     // height: 160,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => Center(
//                         child: SpinKitThreeBounce(
//                       color: controller.randomeColor[randome],
//                     )),
//                     errorWidget: (ctx, url, err) => Image.asset(
//                       'assets/images/noprev.png',
//                       height: 70,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//               flex: 2,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "${controller.products[i]['PRODUCT_NAME']}"
//                                 .toString()
//                                 .length >
//                             15
//                         ? "${controller.products[i]['PRODUCT_NAME']}"
//                                 .toString()
//                                 .substring(0, 15) +
//                             "..."
//                         : "${controller.products[i]['PRODUCT_NAME']}"
//                             .toString(),
//                     style: TextStyle(
//                         color: Colors.grey.shade700,
//                         fontWeight: FontWeight.w500),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "Variant: ${controller.products[i]['VARIANT']}",
//                     style: TextStyle(
//                         color: Colors.grey.shade500,
//                         // fontWeight:
//                         //     FontWeight.w500,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     "Size: ${controller.products[i]['WEIGHT_SIZE']}",
//                     style: TextStyle(
//                         color: Colors.grey.shade500,
//                         // fontWeight:
//                         // FontWeight.w500,
//                         fontSize: 12),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     // "${'${controller.returnPrice(productCode: '${controller.products[i]['PRODUCT_CODE']}')} Tk'}",
//                     "${controller.products[i]['MPR']} TK",
//                     style: TextStyle(
//                         color: controller.randomeColor[randome],
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ZoomTapAnimation(
//                         onTap: () {
//                           int a = int.tryParse(quanity.text) ?? 0;
//                           if (a > 1) {
//                             a--;
//                           } else {
//                             a = 1;
//                           }
//                           if (int.parse(quanity.text) - 1 == 0) {
//                             quanity.text = "1";
//                           }

//                           quanity.text = a.toString();
//                           controller.calculation(
//                               price: double.parse(
//                                   "${controller.products[i]['MPR']}"),
//                               quanity: a);
//                         },
//                         child: Container(
//                           height: 20,
//                           width: 20,
//                           padding: EdgeInsets.all(5),
//                           child: Center(
//                               child: Icon(
//                             FontAwesomeIcons.minus,
//                             color: Colors.grey.shade800,
//                             size: 10,
//                           )),
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(5),
//                                   bottomLeft: Radius.circular(5))),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Container(
//                         width: 60,
//                         height: 20,
//                         child: TextField(
//                           onChanged: (value) {
//                             if (quanity.text.isNotEmpty) {
//                               if (int.parse(quanity.text) > 0) {
//                                 controller.calculation(
//                                     price: double.parse(
//                                         '${controller.products[i]['MPR']}'),
//                                     quanity: int.parse(quanity.text));
//                               } else if (int.parse(quanity.text) <= 0) {
//                                 quanity.text = '1';
//                                 controller.calculation(
//                                     price: double.parse(
//                                         '${controller.products[i]['MPR']}'),
//                                     quanity: int.parse(quanity.text));
//                               } else {
//                                 quanity.text = '1';
//                                 controller.calculation(
//                                     price: double.parse(controller
//                                         .returnPrice(
//                                             productCode:
//                                                 '${controller.products[i]['PRODUCT_CODE']}')
//                                         .toString()),
//                                     quanity: int.parse(quanity.text));
//                               }
//                             } else {
//                               quanity.text = '1';
//                               controller.calculation(
//                                   price: double.parse(
//                                       '${controller.products[i]['MPR']}'),
//                                   quanity: int.parse(quanity.text));
//                             }
//                           },
//                           style: TextStyle(fontSize: 14),
//                           keyboardType: TextInputType.number,
//                           textAlignVertical: TextAlignVertical.center,
//                           textAlign: TextAlign.center,
//                           controller: quanity,
//                           decoration: InputDecoration(
//                             hintStyle: TextStyle(
//                               color: Colors.black,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(2),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade400,
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       ZoomTapAnimation(
//                         onTap: () {
//                           int a = int.tryParse(quanity.text) ?? 0;
//                           a++;
//                           quanity.text = a.toString();
//                           controller.calculation(
//                               price: double.parse(
//                                   '${controller.products[i]['MPR']}'),
//                               quanity: a);
//                         },
//                         child: Container(
//                           height: 20,
//                           width: 20,
//                           padding: EdgeInsets.all(5),
//                           child: Center(
//                               child: Icon(
//                             FontAwesomeIcons.plus,
//                             color: Colors.grey.shade800,
//                             size: 10,
//                           )),
//                           decoration: BoxDecoration(
//                               color: Colors.grey.shade200,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(5),
//                                   bottomRight: Radius.circular(5))),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Obx(() => ZoomTapAnimation(
//                         onTap: controller.isAdded.value
//                             ? () {}
//                             : () {
//                                 CartItem product = CartItem(
//                                   userId: 1,
//                                   productId: controller.products[i]["SKU_CODE"],
//                                   customerName: "",
//                                   beatName: "",
//                                   productName: controller.products[i]
//                                       ["PRODUCT_NAME"],
//                                   catagory: controller.products[i]["CATEGORY"],
//                                   unit: controller.products[i]["UOM"],
//                                   image:
//                                       "https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Red-Carpet-Lip-Color-02-Florida.png",
//                                   price: controller.calculation(
//                                       price: double.parse(
//                                           '${controller.products[i]['MPR']}'),
//                                       quanity: int.parse(quanity.text)),
//                                   brand: controller.products[i]["BRAND_NAME"],
//                                   quantity: int.parse(quanity.text) ?? 1,
//                                   unitPrice: double.parse(
//                                       '${controller.products[i]['MPR']}'),
//                                 );
//                                 controller.addToCart(data: product);

//                                 // addAlert(controller: controller, data: i);
//                               },
//                         child: Container(
//                           height: 30,
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: controller.randomeColor[randome]),
//                           child: Center(
//                             child: Text(
//                               "Add to cart",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                         ),
//                       ))
//                 ],
//               ))
//         ],
//       ));
// }

// return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: COMMONWIDGET.globalAppBar(
//             tittle: "Product Catalogue",
//             backEnabled: true,
//             backFunction: () {
//               Get.back(
//                 // result: controller..products.length,
//                 id: Constants.nestedNavigationNavigatorId,
//               );
//             }),
//         body: Obx(
//           () => controller.isItemCountLoading.value
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SpinKitDoubleBounce(color: controller.randomeColor[1]),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Loading catalogue..",
//                         style: TextStyle(color: controller.randomeColor[1]),
//                       )
//                     ],
//                   ),
//                 )
//               : controller.products.isEmpty
//                   ? Center(
//                       child: Container(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               "assets/images/emptybox.jpg",
//                               height: 200,
//                             ),
//                             Text(
//                               "No products found!",
//                               style: TextStyle(
//                                   color: Colors.grey.shade800, fontSize: 18),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   : Center(
//                       child: Container(
//                       // height: MediaQuery.of(context).size.height,
//                       // width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         children: [
//                           Obx(
//                             () => !controller.isOffline.value
//                                 ? Container()
//                                 : Container(
//                                     height: 40,
//                                     decoration: BoxDecoration(
//                                         color: AppThemes.modernRed),
//                                     child: Center(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Icon(
//                                             Icons
//                                                 .signal_wifi_connected_no_internet_4,
//                                             color: Colors.white,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             "OFFLINE",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                           Expanded(
//                             child: ListView.builder(
//                                 // shrinkWrap: true,
//                                 itemCount: controller.products.length,
//                                 itemBuilder: (context, index) {
//                                   return ZoomTapAnimation(
//                                     onTap: () {
//                                       Get.toNamed(Routes.PRODUCTC,
//                                           arguments: {
//                                             "brand": "${argument['brand']}",
//                                             "type":
//                                                 "${controller.products[index]['GENERIC_NAME']}"
//                                           },
//                                           id: Constants
//                                               .nestedNavigationNavigatorId);
//                                     },
//                                     child: Container(
//                                       height: 150,
//                                       margin: EdgeInsets.symmetric(
//                                           horizontal: 24, vertical: 10),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           border: Border.all(
//                                               width: 1,
//                                               color:
//                                                   controller.randomeColor[1])),
//                                       child: Row(
//                                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             width: 150,
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(15),
//                                                   bottomLeft:
//                                                       Radius.circular(15)),
//                                               child: CachedNetworkImage(
//                                                 imageUrl: "",
//                                                 // "${controller.products[index]['image']}",
//                                                 // height: 160,
//                                                 fit: BoxFit.cover,
//                                                 placeholder: (context, url) =>
//                                                     Center(
//                                                         child:
//                                                             SpinKitThreeBounce(
//                                                   color: controller
//                                                       .randomeColor[1],
//                                                 )),
//                                                 errorWidget: (ctx, url, err) =>
//                                                     Image.asset(
//                                                   'assets/images/noprev.png',
//                                                   // height: 70,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 20,
//                                           ),
//                                           Expanded(
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "${controller.products[index]['GENERIC_NAME']}",
//                                                   style:
//                                                       TextStyle(fontSize: 14),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 15,
//                                           ),
//                                           Container(
//                                             height: 50,
//                                             width: 90,
//                                             // margin: EdgeInsets.only(top: 20),
//                                             decoration: BoxDecoration(
//                                                 color:
//                                                     controller.randomeColor[1],
//                                                 borderRadius: BorderRadius.only(
//                                                     topLeft:
//                                                         Radius.circular(15),
//                                                     bottomLeft:
//                                                         Radius.circular(15))),
//                                             child: Center(
//                                               child: Text(
//                                                 "${controller.products[index]['TTL']} Items",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                         ],
//                       ),
//                     )),
//         ));
  