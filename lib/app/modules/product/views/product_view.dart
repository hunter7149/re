import 'package:red_tail/app/components/common_widgets.dart';
import 'package:red_tail/app/modules/account/views/account_view.dart';
import 'package:red_tail/app/modules/dashboard/views/dashboard_view.dart';
import 'package:red_tail/app/modules/index/views/index_view.dart';
import 'package:red_tail/app/modules/product/controllers/product_controller.dart';
import 'package:red_tail/app/modules/productc/views/productc_view.dart';
import 'package:red_tail/app/modules/services/views/services_view.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  final String argument;
  const ProductView({Key? key, required this.argument}) : super(key: key);
  // String searchValue = '';
  //  int currentIndex = 4;
  //String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: COMMONWIDGET.globalAppBar(
        tittle: "Product Catalogue",
        backEnabled: false,
        backFunction: () {
          print("Hello0");
          // Get.back(
          //   result: controller.count.value,
          //   id: Constants.nestedNavigationNavigatorId,
          // );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                //height: MediaQuery.of(context).size.height/1.5,
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  shrinkWrap: true,
                  children: List.generate(8, (index) {
                    return ZoomTapAnimation(
                      onTap: () {
                        // print("Tapped a Container");
                        //     Fluttertoast.showToast(
                        //         msg: "This is Center Short Toast ${index} ",
                        //         toastLength: Toast.LENGTH_SHORT,
                        //         gravity: ToastGravity.CENTER,
                        //         timeInSecForIosWeb: 1,
                        //         backgroundColor: Colors.red,
                        //         textColor: Colors.white,
                        //         fontSize: 16.0
                        //     );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>  ProductcView(value : index.toString())),
                        // );
                        // Get.to(() => ProductcView(argument: index.toString(),));
                        Get.toNamed(Routes.PRODUCTB,
                            arguments: index.toString(),
                            id: Constants.nestedNavigationNavigatorId);
                        // Get.toNamed(Routes.PRODUCTC,
                        //     arguments: index.toString(),
                        //     id: Constants.nestedNavigationNavigatorId);
                      },
                      child: Container(
                        // width: 100,
                        // height: 100,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.lightBlue.withOpacity(0.09),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(0, 4))
                            ],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 1, color: Colors.blue.shade100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
            ],
          ),
        ),
      ),
    );
  }
}
