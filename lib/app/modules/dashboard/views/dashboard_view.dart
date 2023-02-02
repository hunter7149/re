import 'package:red_tail/app/modules/product/views/product_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../constants.dart';

import '../../../components/custom_image_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              children: [
                // const TextField(
                //   decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 16),
                //       hintText: 'Search Customer',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(32.0),
                //         ),
                //       )),
                //   style: TextStyle(color: Colors.black),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        const CustomImageField(label:"https://static.vecteezy.com/system/resources/thumbnails/003/692/287/small/big-sale-discount-promotion-banner-template-with-blank-product-podium-scene-graphic-free-vector.jpg"),
                        const CustomImageField(label:"https://static.vecteezy.com/system/resources/thumbnails/003/692/287/small/big-sale-discount-promotion-banner-template-with-blank-product-podium-scene-graphic-free-vector.jpg"),
                        const CustomImageField(label:"https://static.vecteezy.com/system/resources/thumbnails/003/692/287/small/big-sale-discount-promotion-banner-template-with-blank-product-podium-scene-graphic-free-vector.jpg"),
                        const CustomImageField(label:"https://static.vecteezy.com/system/resources/thumbnails/003/692/287/small/big-sale-discount-promotion-banner-template-with-blank-product-podium-scene-graphic-free-vector.jpg"),
                        const CustomImageField(label:"https://static.vecteezy.com/system/resources/thumbnails/003/692/287/small/big-sale-discount-promotion-banner-template-with-blank-product-podium-scene-graphic-free-vector.jpg"),
                        const CustomImageField(label:"https://static.vecteezy.com/system/resources/thumbnails/003/692/287/small/big-sale-discount-promotion-banner-template-with-blank-product-podium-scene-graphic-free-vector.jpg")

                      ],
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: MediaQuery.of(context).size.height/1.5,
                         child: GridView.count(
                           //scrollDirection: Axis.vertical,
                           crossAxisCount: 2 ,
                           childAspectRatio: (1 / .75),
                           shrinkWrap: true,
                           children: List.generate(6,(index){
                             return GestureDetector(
                               onTap: () async {
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
                                 //Navigator.of(context).pushNamed('/product');
                                 // Get.toNamed('/product');
                                 controller.goToDetailPage(index);


                               },
                               child:Container(
                                  width: 100,
                                 height: 100,
                                 child: Card(
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15.0),
                                   ),
                                   color: Colors.white,
                                   child:
                                   // Text("Item ${index}"),
                                   Image(
                                     image:AssetImage("assets/images/${index}.jpg") ,
                                   ),
                                 ),
                               ),);
                           }),
                         ),

                       ),

                //const SizedBox(height: 80),
              ],
            ),
          ),

        )
    );
  }
}
