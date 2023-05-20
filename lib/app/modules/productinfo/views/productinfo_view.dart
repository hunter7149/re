import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../components/common_widgets.dart';
import '../../../config/app_themes.dart';
import '../../../models/cartproduct.dart';
import '../controllers/productinfo_controller.dart';

class ProductinfoView extends GetView<ProductinfoController> {
  final dynamic argument;
  ProductinfoView({Key? key, required this.argument}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.setData(data: argument);
    TextEditingController quanity = TextEditingController(text: '1');
    controller.calculation(
        price: controller.returnPrice(
            productCode: controller.products['PRODUCT_CODE']),
        quanity: int.parse(quanity.text));
    double unitprice = controller.totalPrice.value;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 50.0,
          bottomOpacity: 0.0,
          elevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.grey.shade700),
          title: Text("Description"),
          actions: [], //<Widget>[]

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
      body: Center(
          child: Obx(
        () => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //-----------------------------Product Image--------------------------------//
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    // width: 125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${"https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Red-Carpet-Lip-Color-02-Florida.png"}",
                        // height: 160,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: SpinKitRipple(
                          color: AppThemes.modernGreen,
                          size: 50.0,
                        )),
                        errorWidget: (ctx, url, err) => Image.asset(
                          'assets/images/noprev.png',
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${controller.products['PRODUCT_NAME']}',
                    style: TextStyle(
                        fontSize: 22.0,
                        color: AppThemes.modernPlantation,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Weight: ${controller.products['WEIGHT_SIZE']}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Manufacturer: ${controller.products['MANUFACTURER']}',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Color: ${controller.products['COLOR']} ',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' ${controller.totalPrice.value} Tk',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: AppThemes.modernGreen),
                  ),
                  SizedBox(
                    height: 10,
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
                              price: double.parse(unitprice.toString()),
                              quanity: a);
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
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          controller: quanity,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          int a = int.tryParse(quanity.text) ?? 0;
                          a++;
                          quanity.text = a.toString();
                          controller.calculation(
                              price: double.parse(unitprice.toString()),
                              quanity: a);
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
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => COMMONWIDGET.addtoCart(
                        title:
                            controller.isAdded.value ? "Added!" : "Add to cart",
                        funtion: controller.isAdded.value
                            ? () {}
                            : () {
                                CartItem product = CartItem(
                                  userId: 1,
                                  productId: controller.products["SKU_CODE"],
                                  customerName: "",
                                  beatName: "",
                                  productName:
                                      controller.products["PRODUCT_NAME"],
                                  catagory: controller.products["CATEGORY"],
                                  unit: controller.products["UOM"],
                                  image:
                                      "https://images.shajgoj.com/wp-content/uploads/2022/08/NIOR-Red-Carpet-Lip-Color-02-Florida.png",
                                  price: controller.totalPrice.value,
                                  brand: controller.products["BRAND_NAME"],
                                  quantity: int.tryParse(quanity.text),
                                  unitPrice:
                                      controller.products['PRICE'] ?? 500.10,
                                );
                                controller.addToCart(data: product);
                                // addAlert(controller: controller, data: i);
                              },
                        color: controller.isAdded.value
                            ? AppThemes.modernCoolPink
                            : AppThemes.modernGreen),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    height: 1,
                    color: Colors.grey.shade300,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
