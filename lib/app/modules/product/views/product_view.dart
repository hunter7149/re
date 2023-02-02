import 'package:red_tail/app/modules/account/views/account_view.dart';
import 'package:red_tail/app/modules/dashboard/views/dashboard_view.dart';
import 'package:red_tail/app/modules/index/views/index_view.dart';
import 'package:red_tail/app/modules/product/controllers/product_controller.dart';
import 'package:red_tail/app/modules/productc/views/productc_view.dart';
import 'package:red_tail/app/modules/services/views/services_view.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  final String argument;
   const ProductView({Key? key,required this.argument}) : super(key: key);
  // String searchValue = '';
  //  int currentIndex = 4;
    //String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 50.0,
        bottomOpacity: 0.0,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.black87),


        title: const Text("Product Catalogue"),
      actions: <Widget>[
        IconButton(
          icon:Icon(Icons.arrow_back),
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
        icon: const Icon(Icons.library_books_rounded),
        tooltip: 'Menu Icon',
        color: Colors.black87,
        onPressed: () {},
      ),
      ),
        body:
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              children: [
                // const TextField(                //   decoration: InputDecoration(
                //       contentPadding: EdgeInsets.only(left: 16),
                //       hintText: 'Search Customer',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(32.0),
                //         ),
                //       )),
                //   style: TextStyle(color: Colors.black),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     Image.asset("assets/images/back_arrow.jpg",height: 30,width: 30,),
                //     Text.rich(
                //       TextSpan(
                //         style: TextStyle(
                //           fontSize: 17,
                //         ),
                //         children: [
                //           WidgetSpan(
                //             child: Icon(Icons.library_books_rounded),
                //           ),
                //           TextSpan(
                //             text: 'Product Catalogue',
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 5,),
                // Text.rich(
                //   TextSpan(
                //     style: TextStyle(
                //       fontSize: 17,
                //     ),
                //     children: [
                //       WidgetSpan(
                //         child: Icon(Icons.library_books_rounded),
                //       ),
                //       TextSpan(
                //         text: 'Product Catalogue',
                //       )
                //     ],
                //   ),
                // ),

                const SizedBox(height: 10),

                Expanded(
                  //height: MediaQuery.of(context).size.height/1.5,
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2 ,
                    childAspectRatio: (1 / .75),
                    shrinkWrap: true,
                    children: List.generate(8,(index){
                      return GestureDetector(
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
                          Get.toNamed(
                              Routes.PRODUCTC,
                              arguments: index.toString(),
                              id: Constants.nestedNavigationNavigatorId);
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
                              image:AssetImage("assets/images/${index}.png") ,
                            ),
                          ),
                        ),);
                    }),
                  ),

                ),

                const SizedBox(height: 80),
              ],
            ),
          ),

        ),
    );
  }
}
