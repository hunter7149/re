import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:red_tail/app/components/common_widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/productb_controller.dart';

class ProductbView extends GetView<ProductbController> {
  const ProductbView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: COMMONWIDGET.globalAppBar(
          tittle: "Product Catalogue",
          backFunction: () {
            Get.back(
              // result: controller..products.length,
              id: Constants.nestedNavigationNavigatorId,
            );
          }),
      body: Center(
          child: ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                return ZoomTapAnimation(
                  onTap: () {
                    Get.toNamed(Routes.PRODUCTC,
                        arguments: index.toString(),
                        id: Constants.nestedNavigationNavigatorId);
                  },
                  child: Container(
                    // height: 160,
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(width: 1, color: Colors.blue.shade100)),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${controller.products[index]['image']}",
                              // height: 160,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (ctx, url, err) => Image.asset(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.products[index]['name']}",
                                style: TextStyle(fontSize: 24),
                              ),
                              // Text(
                              //   "Description: ${controller.products[index]['description']}",
                              //   style: TextStyle(fontSize: 16),
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //   "USP: ${controller.products[index]['usp']}",
                              //   style: TextStyle(
                              //       fontSize: 16, color: Colors.grey.shade600),
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //   "SKU's: ${controller.products[index]['sku']}",
                              //   style: TextStyle(
                              //       fontSize: 16, color: Colors.grey.shade600),
                              // ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // Text(
                              //   "Variant: ${controller.products[index]['variant']}",
                              //   style: TextStyle(
                              //       fontSize: 16, color: Colors.grey.shade600),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 90,
                          width: 50,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: Colors.teal.shade500,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(15))),
                          child: Center(
                            child: Text(
                              "${controller.products[index]['quantity']}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
