import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:red_tail/app/components/AppColors.dart';
import 'package:red_tail/app/config/app_themes.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../config/app_assets.dart';

class COMMONWIDGET {
  static underDev() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.ASSET_UNDERDEV,
            height: 300,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "This feature is under development.Please wait for the next update.",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static loginInput(
      {required String hinttext,
      required TextEditingController controller,
      required bool obsecure}) {
    return TextField(
      controller: controller,
      obscureText: obsecure,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppThemes.modernBlue,
              width: 1,
            ),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: AppThemes.modernBlue,
          )),
    );
  }

  static button(
      {required String title, required VoidCallback funtion, double? height}) {
    return ZoomTapAnimation(
      onTap: funtion,
      child: Container(
        height: height ?? 40,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: AppThemes.modernBlue,
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  static addtoCart(
      {required String title,
      required VoidCallback funtion,
      double? height,
      double? margin,
      Color? color}) {
    return ZoomTapAnimation(
      onTap: funtion,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: margin ?? 10),
        height: height ?? 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: color ?? APPCOLORS.mainBlue,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }

  static globalAppBar(
      {IconData? leadingIcon,
      Color? leadingIconColor,
      Color? backIconColor,
      IconData? bacKIcon,
      required String tittle,
      required Callback backFunction,
      VoidCallback? leadingFunction,
      bool? backEnabled}) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 50.0,
        bottomOpacity: 0.0,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.grey.shade700),
        title: Text(tittle),
        actions: [
          // backEnabled == true
          //     ? IconButton(
          //         icon: Icon(Icons.arrow_back),
          //         // Image.asset("assets/images/back_arrow.jpg"),
          //         color: backIconColor ?? Colors.grey.shade700,
          //         tooltip: 'Comment Icon',
          //         onPressed: backFunction,
          //       )
          //     : Container()

          // //IconButton
          // //IconButton
        ], //<Widget>[]
        // backgroundColor: Colors.greenAccent[400],
        // elevation: 50.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          // Image.asset("assets/images/back_arrow.jpg"),
          color: backIconColor ?? Colors.grey.shade700,
          tooltip: 'Comment Icon',
          onPressed: backFunction,
        ));
  }
}
