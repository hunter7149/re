import 'dart:ffi';
import 'package:red_tail/app/components/custom_image_catalog.dart';
import 'package:red_tail/app/components/custom_image_val.dart';

import '../../../../constants.dart';
import '../../../components/bottom_navigation.dart';
import '../../../components/custom_image_field.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/productc_controller.dart';

class ProductcView extends GetView<ProductcController> {
  final String argument;
  const ProductcView({Key? key, required this.argument}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.setArgument(argument);
    //final  data=Get.arguments;
    //final String datat=data[0] as String;
    return Scaffold(
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
          icon: const Icon(Icons.library_books_rounded),
          tooltip: 'Menu Icon',
          color: Colors.black87,
          onPressed: () {},
        ),
      ),
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
                height: 700,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CustomImageCatalog(
                        validationText: "${argument}",
                        label: "assets/images/Nior-Aloevera.png"),
                    CustomImageCatalog(
                        validationText: "${argument}",
                        label: "assets/images/Nior-Aloevera.png"),
                    const CustomImageVal(label: "assets/images/product.jpg"),
                    const CustomImageVal(label: "assets/images/product.jpg"),
                    const CustomImageVal(label: "assets/images/product.jpg"),
                    const CustomImageVal(label: "assets/images/product.jpg"),
                    const CustomImageVal(label: "assets/images/product.jpg"),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              //const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
