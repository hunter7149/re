import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

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
    final items = ["item 1", "item 2", "item 3"];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final List<String> ditems = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
      'Item5',
      'Item6',
      'Item7',
      'Item8',
    ];
    String? selectedValue;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 50.0,
          bottomOpacity: 0.0,
          elevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.black87),
          // title: Image.asset("assets/logo/login_logo_hb.png",
          //     width: 150, height: 30, fit: BoxFit.fill),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              // Image.asset("assets/images/back_arrow.jpg"),
              color: Colors.black87,
              tooltip: 'Comment Icon',
              onPressed: () => Get.back(
                result: controller.count.value,
                id: Constants.nestedNavigationNavigatorId,
              ),
            ), //IconButton
            //IconButton
          ], //<Widget>[]
          // backgroundColor: Colors.greenAccent[400],
          // elevation: 50.0,
          leading: IconButton(
            icon:
                new Image.asset("assets/logo/main-menu.png", fit: BoxFit.fill),
            tooltip: 'Menu Icon',
            color: Colors.black87,
            onPressed: () {},
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                //  Padding(height: 1,color:Colors.grey ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     border: Border(
                //       right: BorderSide( //                   <--- right side
                //         color: Colors.grey,
                //         width: 3.0,
                //       ),
                //         left: BorderSide( //                   <--- right side
                //           color: Colors.grey,
                //           width: 3.0,
                //         ),
                //         top: BorderSide( //                   <--- right side
                //           color: Colors.grey,
                //           width: 1.0,
                //         ),
                //         bottom: BorderSide( //                   <--- right side
                //           color: Colors.grey,
                //           width: 1.0,
                //         ),),
                //     shape: BoxShape.rectangle,
                //   ),
                //   child: Row(
                //       children: [
                // Text("Beat",),
                // const    TextField(
                //       decoration: InputDecoration(
                //           contentPadding: EdgeInsets.only(left: 16),
                //           hintText: 'Search Beat',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.all(
                //               Radius.circular(10.0),
                //             ),
                //           )),
                //       style: TextStyle(color: Colors.black),
                //     ),
                // ],

                // ),
                // ),

                Obx(() {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        // color: Colors.blueGrey.shade200,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
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
                          controller.DropdownBeatValueUpdater(newValue!);
                        },
                        items: controller.beatList.value
                            .map<DropdownMenuItem<String>>((String value) {
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
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        // color: Colors.blueGrey.shade200,
                        border:
                            Border.all(width: 1, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
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
                          controller.DropdownCustomerValueUpdater(newValue!);
                        },
                        items: controller.customerList.value
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }), // const TextField(
                //   decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 16),
                //       hintText: 'Search Customer',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(10.0),
                //         ),
                //       )),
                //   style: TextStyle(color: Colors.black),
                // ),
                const SizedBox(height: 20),
                Obx(
                  () => controller.isReorderCompleted.value
                      ? Container()
                      : Text(
                          'Last order',
                          style: TextStyle(
                              fontSize: 22, color: Colors.grey.shade700),
                        ),
                ),
                const SizedBox(height: 10),
                //---------------------Last order option---------------//

                Obx(
                  () => controller.isReorderCompleted.value
                      ? Container()
                      : controller.isReorder.value
                          ? Container(
                              height: 300,
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
                          : Column(
                              children: [
                                Container(
                                  height: 250,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade500),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: context.isPhone
                                          ? 2
                                          : context.isSmallTablet
                                              ? 3
                                              : 4,
                                      childAspectRatio: 4 / 2.6,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                    ),
                                    itemCount: controller
                                        .previousOrder[0]['products'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade500),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: controller
                                                        .previousOrder[0]
                                                            ['products'][index]
                                                            ['img']
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
                                              SizedBox(width: 5),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .previousOrder[0]
                                                              ['products']
                                                              [index]['name']
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                        controller
                                                            .previousOrder[0]
                                                                ['products']
                                                                [index]
                                                                ['catagory']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                    Text(
                                                        controller
                                                            .previousOrder[0]
                                                                ['products']
                                                                [index]['brand']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                    Text(
                                                      'Unit Tk ${controller.previousOrder[0]['products'][index]['price'].toString()}',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.addAllToCart();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade300,
                                        // border: Border.all(color: Colors.grey.shade500),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    child: Center(
                                        child: Text(
                                      "ADD TO CART",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )),
                                  ),
                                )
                              ],
                            ),
                ),
                SizedBox(height: 16),
                Text(
                  'Our brands',
                  style: TextStyle(fontSize: 22, color: Colors.grey.shade700),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 300,
                  decoration: BoxDecoration(
                      // color: Colors.blueGrey.shade200,
                      border: Border.all(width: 1, color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(10)),
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2,
                    children: List.generate(10, (index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PRODUCTC,
                              arguments: index.toString(),
                              id: Constants.nestedNavigationNavigatorId);
                        },
                        child: Container(
                          // width: 100,
                          // height: 100,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue.withOpacity(0.02),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 4))
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: Colors.blue.shade100)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: AssetImage("assets/images/${index}.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // Container(
                        //   child: Card(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //     color: Colors.white,
                        //     child:
                        //         // Text("Item ${index}"),
                        //         Image(
                        //       image: AssetImage("assets/images/${index}.png"),
                        //     ),
                        //   ),
                        // ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: menus.length,
                  itemBuilder: (BuildContext context, int index) {
                    MenuModel menu = menus[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            // color: Colors.blueGrey.shade200,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              menu.tittle ?? '',
                              style: TextStyle(fontSize: 24),
                            ),
                            Image.asset(
                              menu.image ?? AppAssets.ASSET_EMPTY_IMAGE,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppAssets.ASSET_BRAND_IMAGE,
                                  height: 40,
                                );
                              },
                              height: 64,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
