import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
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
        body: Obx(
          () => controller.isItemCountLoading.value
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitDoubleBounce(color: AppThemes.modernGreen),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Loading catalogue..",
                        style: TextStyle(color: AppThemes.modernGreen),
                      )
                    ],
                  ),
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
                            Text("No products found!"),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return ZoomTapAnimation(
                              onTap: () {
                                Get.toNamed(Routes.PRODUCTC,
                                    arguments: {
                                      "brand": "${argument['brand']}",
                                      "type":
                                          "${controller.products[index]['GENERIC_NAME']}"
                                    },
                                    id: Constants.nestedNavigationNavigatorId);
                              },
                              child: Container(
                                height: 150,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 1,
                                        color: AppThemes.modernGreen)),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        child: CachedNetworkImage(
                                          imageUrl: "",
                                          // "${controller.products[index]['image']}",
                                          // height: 160,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                              child: SpinKitThreeBounce(
                                            color: AppThemes.modernGreen,
                                          )),
                                          errorWidget: (ctx, url, err) =>
                                              Image.asset(
                                            'assets/images/noprev.png',
                                            // height: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.products[index]['GENERIC_NAME']}",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 90,
                                      // margin: EdgeInsets.only(top: 20),
                                      decoration: BoxDecoration(
                                          color: AppThemes.modernGreen,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15))),
                                      child: Center(
                                        child: Text(
                                          "${controller.products[index]['TTL']} Items",
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
        ));
  }
}
