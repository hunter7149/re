import 'package:sales/app/components/common_widgets.dart';
import 'package:sales/app/config/app_themes.dart';
import 'package:sales/app/modules/product/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../constants.dart';
import '../../../routes/app_pages.dart';

class ProductView extends GetView<ProductController> {
  final String argument;

  const ProductView({Key? key, required this.argument}) : super(key: key);
  // String searchValue = '';
  //  int currentIndex = 4;
  //String value;

  @override
  Widget build(BuildContext context) {
    List brands = controller.brands;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: COMMONWIDGET.globalAppBar(
      //   tittle: "Product Catalogue",
      //   backEnabled: false,
      //   backFunction: () {
      //     // Get.back(
      //     //   result: controller.count.value,
      //     //   id: Constants.nestedNavigationNavigatorId,
      //     // );
      //   },
      // ),
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
                  crossAxisCount: _getCrossAxisCount(context),
                  childAspectRatio: 1.2,
                  shrinkWrap: true,
                  children: List.generate(10, (index) {
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
                            arguments: {"brand": brands[index]},
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
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            border: Border.all(
                                width: 1, color: AppThemes.modernGreen)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
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
}
